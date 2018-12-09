This is your fourth step.

## Task

Import in the manager object from ncclient. 

`from ncclient import manager`{{execute}}

Open a connection to IOS_XE_1 using the manager object. 

`m = manager.connect(
    host=env_lab.IOS_XE_1["host"],
    port=env_lab.IOS_XE_1["netconf_port"],
    username=env_lab.IOS_XE_1["username"],
    password=env_lab.IOS_XE_1["password"],
    hostkey_verify=False
    )`{{execute}}

Review the capabilities of the device by looping over the `server_capabilities` property of the manager object. 

`for capability in m.server_capabilities:
    print(capability)

`{{execute}}

What is printed is a line per capability. Each line includes several pieces of data including the Model URI, Model Name, Model Version, and other details. Below we've grabbed two capabilities and formatted the output to better inspect. 

```urn:ietf:params:xml:ns:yang:ietf-interfaces
  ? module=ietf-interfaces
  & revision=2014-05-08
  & features=pre-provisioning,if-mib,arbitrary-names
  & deviations=ietf-ip-devs
.
http://cisco.com/ns/ietf-ip/devs
  ? module=ietf-ip-devs
  & revision=2016-08-10
```

Now close the connection to the device to end the NETCONF session. 

`m.close_session()`{{execute}}

Exit the Python interpreter.

`exit()`{{execute}}
