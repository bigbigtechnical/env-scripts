#!/bin/bash

SCRIPT="${BASH_SOURCE[0]}"
while [ -L "$SCRIPT" ]; do
  DIR="$( cd -P "$( dirname "$SCRIPT" )" && pwd )"
  SCRIPT="$(readlink "$SCRIPT")"
done
DIR="$( cd -P "$( dirname "$SCRIPT" )" && pwd )"

. "${DIR}/vbox.sh"

if [ -z "$1" ]
then
    echo "Usage: $0 <name> <hostname> <address>"
    exit
fi

VM_NAME=$1
VM_HOSTNAME=$2
VM_ADDRESS=$3

vm_create ${VM_NAME}
vm_setvar ${VM_NAME} VMHOSTNAME ${VM_HOSTNAME}
vm_setvar ${VM_NAME} VMADDRESS ${VM_ADDRESS}

