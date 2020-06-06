#!/bin/bash

# Git installation

# ref: https://linuxize.com/post/how-to-install-git-on-raspberry-pi/
# prerequisite: you must be logged in with a user with sudo power.

sudo apt update
sudo apt install git
echo "Executing git --version. If is everything ok, you should see the Git version below."
git --version