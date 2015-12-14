#!/bin/bash
set -e

# update hostname
aws="/usr/bin/aws --region ap-northeast-1"
instance_id=$(curl -s http://169.254.169.254/latest/meta-data/instance-id)
tag_name=$(${aws} ec2 describe-instances --instance-id ${instance_id} --output json|jq '.Reservations[].Instances[].Tags[] | select(.Key=="Name").Value' -r)
sudo hostname "${tag_name}"
sudo echo ${tag_name} > /etc/hostname
sudo perl -pi -e "s/127.0.0.1 localhost/127.0.0.1 localhost ${tag_name}/g" /etc/hosts

# /data
sudo blockdev --setra 128 /dev/xvdb
sudo mkfs.ext4 /dev/xvdb
echo "/dev/xvdb  /data ext4  defaults,nofail,noatime 0 2" | sudo tee -a /etc/fstab
sudo mountall
sudo chown -R mongodb:mongodb /data
