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
    print(capability)`{{execute}}

