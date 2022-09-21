#!/bin/bash


sudo echo "
0 0	* * * root /usr/bin/apt update -q -y >> /var/log/apt/automaticupd
10 0	* * * root /usr/bin/apt upgrade -q -y >> /var/log/apt/automaticupd
20 0	1 * * root /sur/bin/apt dist-upgrade -q -y >> /var/log/apt/automaticupd
" >> /etc/crontab
