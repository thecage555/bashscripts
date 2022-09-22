#! /bin/bash
sudo apt -y update
sudo apt -y upgrade

sudo apt install -y samba
sudo apt install -y python3
sudo apt install -y glances

sudo mkfs.ext4 -F /dev/md1

OUTPUT="$(sudo blkid -s UUID -o value /dev/md1$partnumber)"
echo "UUID="$OUTPUT"    /md1/stuff/    ext4   rw, user, auto    0    0" | sudo tee -a /etc/fstab

sudo mkdir /md1/stuff/video
sudo mount /md1/stuff/
sudo chmod 777 /md1
sudo chmod 777 /md1/stuff
sudo chmod 777 /md1/stuff/video
sudo chmod 700 ~/.ssh

echo "
#NAS Share dir
[NASShare]
 comment = NAS_Share
 path = md1/stuff
 read only = yes
 guest ok = yes" | sudo tee -a /etc/samba/smb.conf
