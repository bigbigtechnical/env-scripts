#!/bin/bash
VMHOSTNAME=$(VBoxControl --nologo guestproperty get VMHOSTNAME | cut -d ' ' -f 1 --complement)
VMADDRESS=$(VBoxControl --nologo guestproperty get VMADDRESS | cut -d ' ' -f 1 --complement)
VMDOMAIN=".example.bbt"

# /etc/hosts
echo "${VMADDRESS} ${VMHOSTNAME}${VMDOMAIN} ${VMHOSTNAME}" >> /etc/hosts

# /etc/sysconfig/network
sed -i "s/HOSTNAME=.*/HOSTNAME=${VMHOSTNAME}${VMDOMAIN}/g" /etc/sysconfig/network

# /etc/sysconfig/network-scripts/ifcfg-eth1
sed -i "s/dhcp/none/g" /etc/sysconfig/network-scripts/ifcfg-eth1
echo "IPADDR=\"${VMADDRESS}\"
NETMASK=\"255.255.255.0\"" >> /etc/sysconfig/network-scripts/ifcfg-eth1

hostname ${VMHOSTNAME}${VMDOMAIN}
/etc/init.d/network restart

sed -i "/vm_init/d" /etc/rc.local
