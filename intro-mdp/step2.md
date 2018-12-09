
## Step 2: Exploring YANG Models with pyang

An important aspect of developing with new languages and APIs, is having access to tools and utilities that make the job easier. One very helpful tool for working with YANG data models is pyang, a YANG validator, converter, and code generator written in Python. You will use this tool to look at a few basic YANG Models.

1. Change into the directory for this lab. 

`cd /home/scrapbook/tutorial/katacoda-mdp/intro-mdp/yang`{{execute}}

2. Within the directory is a folder called models that contain several YANG Models from the IETF, OpenConfig and Cisco. 

`ls models`{{execute}}

3. Change into the models directory.

`cd models`{{execute}}

4. One of the models is ietf-interfaces.yang. This is a model provided by the IETF that models a standard network interface. Open the file in a text editor to view the model in it's native YANG language. Notice how native YANG model definitions are very long and descriptive (as you'd expect and want). As a consumer of YANG models, working in the native YANG is thankfully unnecessary.

5. The pyang module can generate much simpler to understand representations of a YANG model. Run the following command to generate a clear-text tree view of the model.

`pyang -f tree ietf-interfaces.yang`{{execute}}

6. Some things to notice about the output
  * The "module" ietf-interfaces provides two "containers":
    * interfaces
    * interfaces-state
  * Within each "container" is a "list" called "interface"
    * A single instance of an interface is identified by a unique "key" of [name]
  * Every "leaf" attribute (ex name, description, type, etc.) has the following details:
    * Either read-write (rw) or read-only (ro)
    * Some are optional (?)
    * Explicitly-defined data types
    
7. Included in the models\ directory is the OpenConfig YANG model for "interfaces". Take a look at it and compare what you see to the IETF version. 

`pyang -f tree openconfig-interfaces.yang`{{execute}}

8. Open `/home/scrapbook/tutorial/katacoda-mdp/intro-mdp/yang/example-ietf-interfaces-data.xml` in the text editor. This file is an example of data returned from a network device representing the interfaces modeled using the ietf-interfaces.yang model that you just explored. A partial output of the file is shown here. 

```XML
<interfaces xmlns="urn:ietf:params:xml:ns:yang:ietf-interfaces">
    <interface>
        <name>GigabitEthernet2</name>
        <description>WAN Interface</description>
        <type xmlns:ianaift="urn:ietf:params:xml:ns:yang:iana-if-type">ianaift:ethernetCsmacd</type>
        <enabled>true</enabled>
        <ipv4 xmlns="urn:ietf:params:xml:ns:yang:ietf-ip">
            <address>
                <ip>172.16.12.1</ip>
                <netmask>255.255.255.0</netmask>
            </address>
        </ipv4>
        <ipv6 xmlns="urn:ietf:params:xml:ns:yang:ietf-ip"/>
    </interface>
</interfaces>
```

9. You should recognize the YANG model elements represented:
  * container interfaces
    * <interfaces xmlns="urn:ietf:params:xml:ns:yang:ietf-interfaces">...</interfaces>
    * The attribute xmlns="urn:ietf:params:xml:ns:yang:ietf-interfaces" identifies the particular YANG model
  * list of individual interfaces
    * <interface>..</interface>
  * leaf attributes
    * <name>..</name>
    * <type>..</type>
    * <enabled>..</enabled

