# Latest Fedora
FROM fedora:21
MAINTAINER syuu1228 syuu@dokukino.com

# update packages first
RUN yum -y update

# install packages for OSv
RUN yum -y install gcc-c++ gcc-c++-aarch64-linux-gnu git gdb qemu-img qemu-system-x86 libvirt maven java-1.7.0-openjdk ant autoconf automake boost-static genromfs libtool flex bison maven-shade-plugin python-dpkt tcpdump gdb gnutls-utils openssl python-requests p11-kit patch wget unzip ncurses ncurses-devel libstdc++-static openssl-libs openssl-devel libedit-devel

# create device file to use KVM
RUN mknod /dev/kvm c 10 232

# checkout and build OSv
RUN cd /root && git clone https://github.com/cloudius-systems/osv.git
RUN cd /root/osv && git submodule update --init --recursive && make -j2 && ./scripts/build

# install Ruby for OSv/Ruby
RUN gpg2 --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
RUN \curl -sSL https://get.rvm.io | bash -s stable
RUN /usr/local/rvm/bin/rvm install ruby-2.2.0

# apply patch, install extra packages for Seastar
ADD 0001-Add-Seastar.patch /root/
RUN cd /root/osv/apps && git apply /root/0001-Add-Seastar.patch
RUN yum -y install python3 gcc-c++ libaio-devel ninja-build ragel hwloc-devel numactl-devel libpciaccess-devel cryptopp-devel xen-devel boost-devel libasan libubsan
