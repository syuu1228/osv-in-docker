# osv-in-docker
OSv building environment on Docker, for non-Fedora users

### Prerequire

Install libvirtd and KVM, make it usable. Be sure virbr0 is available.

### How to build & run

--privileged and --net=host is required to use KVM and virbr0 from Docker container.
```
docker pull syuu1228/osv-in-docker:latest
docker run --privileged --net=host -i -t syuu1228/osv-in-docker /bin/bash
```

### Usage of the VM

Wait until finish running setup script on first startup.
Then login as 'seastar', login prompt will ask for entering new password.

After login to seastar, initialize DPDK module by following instruction:
```
sudo su - # entering root user
resize    # extend console to actual terminal window size
export TERM=xterm-256color # set terminal type
cd ~/dpdk
./tools/setup.sh

# input numbers by following order:
(type 9 to re-compile DPDK)
(type 12 to insert IGB UIO module)
(type 15, then input "64" to setup hugepage mappings)
(type 18, then input PCI device id something like "0000:xx:yy.z",
which is shown at 'Network devices using DPDK-compatible driver')
(type 30 to exit)

cd ~/seastar
# httpd example
env LD_LIBRARY_PATH=~/dpdk/x86_64-native-linuxapp-gcc/lib/ \
./build/release/apps/httpd/httpd --network-stack native --dpdk-pmd --csum-offload off
```



