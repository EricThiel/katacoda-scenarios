
## Step 2: Python says <hello> with ncclient

Open an interactive Python interpreter and run the prep.py file. This file will import in the details about the different lab infrastructure that will be used for this lab. 

`python -i prep.py`{{execute}}

The device we will be working with is represented by the constant env_lab.IOS_XE_1. 

`print(env_lab.IOS_XE_1)`{{execute}}

If successful, you should see output similar to:
`{'username': 'cisco', 'restconf_port': 9443, 'ssh_port': 5001, 'netconf_port': 5011, 'host': '173.37.56.91', 'password': 'C1sco12345'}`

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

```
for capability in m.server_capabilities:
    print(capability)


```{{execute}}

What is printed is a line per capability. Each line includes several pieces of data including the Model URI, Model Name, Model Version, and other details. Below we've grabbed two capabilities and formatted the output to better inspect. 

```
urn:ietf:params:xml:ns:yang:ietf-interfaces
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
