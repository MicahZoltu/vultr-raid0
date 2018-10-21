#/bin/bash

# I know that Vultr runs startup scripts only once upon server installation.
# But still added this simple protection to be sure that your servers won't get wiped upon reboot.
if [ -f /etc/ipxe-preseed.flag ]
then
	exit
fi

apt-get update
apt-get -y install grub-ipxe

echo '#!ipxe
dhcp
set base-url http://archive.ubuntu.com/ubuntu/dists/bionic/main/installer-amd64/current/images/netboot/ubuntu-installer/amd64
kernel ${base-url}/linux
initrd ${base-url}/initrd.gz
# Here goes the URL of the installation config. Must be accessible over plain HTTP, HTTPS does not work.
imgargs linux auto=true priority=critical url=http://example.com/path/preseed-raid0.cfg
boot
' > /boot/ubuntu-install-raid0.ipxe

cp /etc/grub.d/20_ipxe /etc/grub.d/09_ipxe-raid0
sed -i 's/^\}/initrd16\ \/boot\/ubuntu-install-raid0\.ipxe\n\}/' /etc/grub.d/09_ipxe-raid0

/usr/sbin/update-grub

/sbin/reboot

