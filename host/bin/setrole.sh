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
    echo "Usage: $0 <name> <role1> <role2>..."
    exit
fi

VM_NAME=$1
shift

vm_setvar ${VM_NAME} VMCLASSES "$@"
