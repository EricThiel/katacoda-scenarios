This is your third step.

## Task

Open an interactive Python interpreter and run the prep.py file. This file will import in the details about the different lab infrastructure that will be used for this lab. 

`python -i prep.py`{{execute}}

The device we will be working with is represented by the constant env_lab.IOS_XE_1. 

`print(env_lab.IOS_XE_1)`{{execute}}

If successful, you should see output similar to:
`{'username': 'cisco', 'restconf_port': 9443, 'ssh_port': 5001, 'netconf_port': 5011, 'host': '173.37.56.91', 'password': 'C1sco12345'}`