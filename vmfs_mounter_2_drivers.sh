#!/bin/sh


FOLDER_TO_BE_CREATED=/mnt/vmfs
SECOND_HDD_MOUNT=/mnt/second_drive
COPY_DATA_FROM=$1
COPY_DATA_TO=$2

prereqs(){
echo "please run fdisk -l 1st before running the script"
sudo fdisk -l
sudo apt-get install vmfs-tools -y
sudo apt install vmfs6-tools -y
sudo apt install rsync -y
}

stuff(){
echo "making folder $FOLDER_TO_BE_CREATED"
sleep 2
sudo mkdir $FOLDER_TO_BE_CREATED
echo "checking disks which are avalible"
sleep  2
echo "atemmpting to mount vmware folder via verison 5"
sudo vmfs-fuse $COPY_DATA_FROM $FOLDER_TO_BE_CREATED
echo "atemmpting to mount vmware folder via verison 6"
sudo mkdir $FOLDER_TO_BE_CREATED
sudo vmfs6-fuse $COPY_DATA_FROM  $FOLDER_TO_BE_CREATED
echo "checking vmfs-fuse of $COPY_DATA_FROM to $FOLDER_TO_BE_CREATED"
sleep 2
sudo ls -lh $FOLDER_TO_BE_CREATED

echo "mounting 2nd HDD"
sudo mkdir $SECOND_HDD_MOUNT
sudo mount $COPY_DATA_TO $SECOND_HDD_MOUNT
sudo "chcking mount of $COPY_DATA_TO to $SECOND_HDD_MOUNT"
sleep 2
sudo ls -lh $SECOND_HDD_MOUNT

echo "installing rsync"

sudo systemctl restart rsync
echo "running command sudo rsync -a -P  $FOLDER_TO_BE_CREATED $SECOND_HDD_MOUNT"
sudo rsync -a -P  $FOLDER_TO_BE_CREATED $SECOND_HDD_MOUNT
}


overall(){
prereqs
#stuff
}


overall
