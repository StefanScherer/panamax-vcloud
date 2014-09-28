#!/bin/bash
# instructions from https://coreos.com/docs/running-coreos/platforms/vmware/

if [ ! -f coreos_production_vmware_insecure.zip ]; then
  curl -LO http://stable.release.core-os.net/amd64-usr/current/coreos_production_vmware_insecure.zip
fi

if [ ! -d coreos_production_vmware_insecure ]; then
  unzip coreos_production_vmware_insecure.zip -d coreos_production_vmware_insecure
fi

cd coreos_production_vmware_insecure
mkdir coreos
/Applications/VMware\ Fusion.app/Contents/Library/VMware\ OVF\ Tool/ovftool coreos_production_vmware_insecure.vmx coreos/coreos.insecure.ova
