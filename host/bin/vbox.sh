#!/bin/bash

VM_TEMPLATE="Big Big Template"
VM_SNAPSHOT="Scriptable"

function vm_create {
    VM_TARGET=$1;
    VBoxManage clonevm "${VM_TEMPLATE}" --snapshot "${VM_SNAPSHOT}" --options link --name "${VM_TARGET}" --register
}

function vm_delete {
    VM_TARGET=$1;
    VBoxManage unregistervm "${VM_TARGET}" --delete
}

function vm_setvar {
    VM_TARGET=$1;
    VM_VARNAME=$2;
    shift 2;
    VM_VALUE=$@;
    VBoxManage guestproperty set "${VM_TARGET}" "${VM_VARNAME}" "${VM_VALUE}"
}

function vm_start {
    VM_TARGET=$1;
    VBoxManage startvm "${VM_TARGET}" --type headless
}

function vm_stop {
    VM_TARGET=$1;
    VBoxManage controlvm "${VM_TARGET}" acpipowerbutton
}

