#!/bin/bash

QSTRING="qemu:///system"
BOXNAME="base-debian-9"
HOSTNAME=$(echo $1 | cut -f1 -d.)
DOMAIN=$(echo $1 | cut -f2- -d.)

virsh --connect $QSTRING list --all | grep $BOXNAME 
if [ "$?" == 0 ]; then
  virsh --connect $QSTRING destroy $BOXNAME
  virsh --connect $QSTRING undefine $BOXNAME --remove-all-storage
fi

virt-install \
  --connect $QSTRING \
  --memory 1024 \
  --vcpus 2 \
  --cpu host \
  --disk size=10,pool=vmlandscape,bus=virtio,cache=unsafe \
  --net network=vmlandscape-net,model=virtio \
  --os-variant debian8 \
  --os-type linux \
  --name "$BOXNAME" \
  --noautoconsole \
  --console pty,target_type=serial \
  --location 'http://192.168.122.1:9999/debian/dists/stretch/main/installer-amd64/' \
  --extra-args "console=tty0,ttyS0,115200n8 serial auto language=en country=CH locale=en_GB.UTF-8 keymap=en hostname=base-debian-9 domain=sigkill.noexit preseed/url=http://192.168.122.1/debian/debian.preseed "
