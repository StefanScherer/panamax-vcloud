# coreos-vcloud

## Build OVA to upload into vCloud
See also https://coreos.com/docs/running-coreos/platforms/vmware/

```bash
./coreos-vmx-to-ova.sh
```

Upload OVA file to vCloud catalog.

## Create vApp panamax

Create a new vApp based on that catalog.
Set disk size to eg. 40 GByte, RAM and CPUs as you need.
Power on the vApp.

As it has no VMware Tools installed, the vCloud Director does not show you the IP address of the panamax machine.

## Add Edge Gateway NAT rules

Check the IP address of the panamax-vm with Web GUI. Click on the monitor and have a look at the login screen:

```
This is localhost.unknown_domain (Linux x86_64 3.15.8+) 15:58:55
SSH host key: xx:xx:xx:xx:...
enp0s17: 10.115.4.133 xxx::xxx:xxxx:xxxx:xxxx

localhost login:
```

With this information, go to Adminstration -> Virtual Datacenters -> your VCD -> Edge Gateways -> your Edge -> Edge Gateway Services ... 
The following dialog has tabs. Open the NAT tab and add some DNAT rules:

```
10.100.50.4:22 -> 10.115.4.113:22
10.100.50.4:3000 -> 10.115.4.113:3000
10.100.50.4:8080 -> 10.115.4.113:8080
```

## Add SSH key

```bash
cd coreos_production_vmware_insecure
ssh -i insecure_ssh_key core@10.100.50.4
cat ~/.ssh/id_rsa.pub | ssh core@10.100.50.4 -i insecure_ssh_key update-ssh-keys -a user
ssh core@10.100.50.4 update-ssh-keys -D oem
ssh core@10.100.50.4
```

## Install Panamax

See also https://github.com/CenturyLinkLabs/panamax-ui/wiki/Installing-Panamax

```bash
ssh core@10.100.50.4
sudo su
curl -O http://download.panamax.io/installer/pmx-installer-latest.zip && unzip pmx-installer-latest.zip -d /var/panamax
cd /var/panamax
./coreos install --stable
```


