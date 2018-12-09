This is your third step.

## Task

Open an interactive Python interpreter and run the prep.py file. This file will import in the details about the different lab infrastructure that will be used for this lab. 

`python -i prep.py`{{execute}}

The device we will be working with is represented by the constant env_lab.IOS_XE_1. 

`print(env_lab.IOS_XE_1)`{{execute}}

If successful, you should see output similar to:
`{'username': 'root', 'restconf_port': 9443, 'ssh_port': 8181, 'netconf_port': 10000, 'host': 'ios-xe-mgmt.cisco.com', 'password': 'D_Vay!_10&'}`