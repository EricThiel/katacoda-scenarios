#!/bin/bash
apt-get install -y python3-venv
git clone https://github.com/securenetwrk/katacoda-mdp.git
python3 -m venv venv
source venv/bin/activate
cd katacoda-mdp/intro-mdp
pip3 install -r requirements.txt