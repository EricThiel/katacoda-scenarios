Walking through automating your network with NETCONF

## Task

1. Open the file `katacoda-mdp/intro-mdp/netconf/get_interface_list.py` in a text editor. Let's walk through the key parts to observe. 

2. Take a look at the imports. We already saw ncclient, but in addition are the xmltodict and xml.dom.minidom. These libraries make working with the XML data easier. 

```
from ncclient import manager
import xmltodict
import xml.dom.minidom
```

3. In this script the goal is to retrieve the interfaces using the ietf-interfaces model. If we don't specify a filter in the request, NETCONF will return everything available across all data models. Using a filter is more efficient for the network device & for your code. 

```XML
# Create an XML filter for targeted NETCONF queries
netconf_filter = """
<filter>
  <interfaces xmlns="urn:ietf:params:xml:ns:yang:ietf-interfaces">
    <interface></interface>
  </interface>
</filter>"""
```

4. The with statement in Python creates a context handler to automatically close resources when no longer needed. It is often used when accessing files, but can be used for other connections, like with NETCONF connections. 

```XML
with manager.connect(
        host=env_lab.IOS_XE_1["host"],
        port=env_lab.IOS_XE_1["netconf_port"],
        username=env_lab.IOS_XE_1["username"],
        password=env_lab.IOS_XE_1["password"],
        hostkey_verify=False
        ) as m:
```

5. With the active connection, next the <get-config> operation is executed, including the filter. 

`netconf_reply = m.get_config(source = 'running', filter = netconf_filter)`

6. After the connection netconf_reply represents the rpc-reply from the device. In this line we print out the raw XML in a "pretty" fashion. 

` print(xml.dom.minidom.parseString(netconf_reply.xml).toprettyxml())`

7. In these lines we convert the XML string that was returned to a Python Ordered Dictionary that can be easily manipulated, and then drill into the returned data to get a list of interfaces. 

```XML
# Parse the returned XML to an Ordered Dictionary
netconf_data = xmltodict.parse(netconf_reply.xml)["rpc-reply"]["data"]

# Create a list of interfaces
interfaces = netconf_data["interfaces"]["interface"]
```

8. And finally, we loop over the interfaces, printing out the interface names and status. 

```XML
for interface in interfaces:
    print("Interface {} enabled status is {}".format(
            interface["name"],
            interface["enabled"]
            )
        )
```

9. Close the script and run it from the terminal. 

` python get_interface_list.py`{{execute}}

## Hands on: Adding something to the configuration

1. Open the file add_loopback.py in a text editor. Let's walk through the new parts to observe. 

2. In order to add something via NETCONF, we need to build an XML payload that has the desired configuration modeled based on an available YANG model. Here a template for an XML payload to add an interface based on the ietf-interfaces model is created. 

```XML
# Create an XML configuration template for ietf-interfaces
netconf_interface_template = """
<config>
    <interfaces xmlns="urn:ietf:params:xml:ns:yang:ietf-interfaces">
        <interface>
            <name>{name}</name>
            <description>{desc}</description>
            <type xmlns:ianaift="urn:ietf:params:xml:ns:yang:iana-if-type">
                {type}
            </type>
            <enabled>{status}</enabled>
            <ipv4 xmlns="urn:ietf:params:xml:ns:yang:ietf-ip">
                <address>
                    <ip>{ip_address}</ip>
                    <netmask>{mask}</netmask>
                </address>
            </ipv4>
        </interface>
    </interfaces>
</config>"""
```

3. Next the script asks the user for the details on a new Loopback interface to add. 

```XML
# Ask for the Interface Details to Add
new_loopback = {}
new_loopback["name"] = "Loopback" + input("What loopback number to add? ")
new_loopback["desc"] = input("What description to use? ")
new_loopback["type"] = IETF_INTERFACE_TYPES["loopback"]
new_loopback["status"] = "true"
new_loopback["ip_address"] = input("What IP address? ")
new_loopback["mask"] = input("What network mask? ")
```

4. Here the template is combined with the data from the user. 

```XML
# Create the NETCONF data payload for this interface
netconf_data = netconf_interface_template.format(
        name = new_loopback["name"],
        desc = new_loopback["desc"],
        type = new_loopback["type"],
        status = new_loopback["status"],
        ip_address = new_loopback["ip_address"],
        mask = new_loopback["mask"]
    )
```

5. Lastly, here the <edit-config> operation is executed. 

`netconf_reply = m.edit_config(netconf_data, target = 'running')`

6. Close the script and run it from the terminal. Provide the inputs for the new interface when asked. 

`python add_loopback.py`{{execute}}


## Hands On: Deleting from the configuration

Now you've added a Loopback, but what if you want to remove it from the configuration?

1. Open the file delete_loopback.py in a text editor. Let's walk through the new parts to observe. 

2. Once again we have an XML payload template, but notice this time the operation="delete" on the <interface> leaf. This is how you specify the specific activity to take on an object. 

```XML
netconf_interface_template = """
<config>
    <interfaces xmlns="urn:ietf:params:xml:ns:yang:ietf-interfaces">
        <interface operation="delete">
            <name>{name}</name>
        </interface>
    </interfaces>
</config>"""
```

3. That's it... not much different from adding.

4. Close the script and run it from the terminal. Provide the number of the Loopback you added in the last step. 

` python delete_loopback.py`{{execute}}

* Note: if you try to delete an interface that doesn't exist, you will get a NETCONF error. Give it a try!


## Hands On: Saving the configuration

After you've made network configuration changes, you may want to save them to the startup configuration. NETCONF supports the ability for vendors to create native RPC operations for activities that are specific to their platform. IOS XE devices support a <save-config> operation as part of one of the native data models. Let's see how it works! 

1. Open the file save_config.py in a text editor. Let's walk through the new parts to observe. 

2. To craft a custom RPC, we'll be leveraging another object from the ncclient package. Here we import xml_.

` from ncclient import manager, xml_`

3. Rather than creating a NETCONF <filter> or <config>, this time we are explicitly calling the RPC from a model. 

```XML
 save_body = """
 <cisco-ia:save-config xmlns:cisco-ia="http://cisco.com/yang/cisco-ia"/>
 """
```

4. As we are sending a custom RPC, we use the dispatch method to send the custom operation. 

` netconf_reply = m.dispatch(xml_.to_ele(save_body))`

5. Okay, close the script and run it from the terminal. Look at the body of the reply returned. You should see a clear indication of success. 

` python save_config.py`{{execute}}

```XML
 # Partial Example Output
 <result xmlns="http://cisco.com/yang/cisco-ia">Save running-config successful</result>
```






