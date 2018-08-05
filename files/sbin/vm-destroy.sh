#!/bin/bash

virsh --connect qemu:///system destroy $1
virsh --connect qemu:///system undefine $1 --remove-all-storage
