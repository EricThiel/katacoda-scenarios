
## Step 6: Verifying the Solution

Think you've got the mission complete? Let's find out. 

## Running Your Code

1. Change into the Mission directory. 

`cd /home/scrapbook/tutorial/katacoda-mdp/intro-mdp/mission01`{{execute}}

2. Run the mission file. 

`python netconf_configure_ips.py`{{execute}}

## What to Expect

If you successfully completed the mission, the script should complete without errors and show output like this. 

```text
Checking the current IP configuration on GigabitEthernet2 on devices
Device: 198.18.134.11
  Interface: GigabitEthernet2
    IPv4: not configured.


Device: 198.18.134.12
  Interface: GigabitEthernet2
    IPv4: not configured.


Attempting to configure GigabitEthernet2 IP addressing
Device 198.18.134.11 updated successfully

Device 198.18.134.12 updated successfully

Re-Checking the current IP configuration on GigabitEthernet2 on devices
Device: 198.18.134.11
  Interface: GigabitEthernet2
    IPv4: 172.16.255.1/24
Device: 198.18.134.12
  Interface: GigabitEthernet2
    IPv4: 172.16.255.2/24

```


