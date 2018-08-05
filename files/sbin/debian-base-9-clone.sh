#!/bin/bash -x

virt-clone --connect qemu:///system --original base-debian-9 --auto-clone -n $1
virt-sysprep --connect qemu:///system -d $1 --hostname=$1
virsh --connect qemu:///system start $1
