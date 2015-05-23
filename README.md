# osv-in-docker
OSv building environment on Docker, for non-Fedora users

### Prerequire

Install libvirtd and KVM, make it usable. Be sure virbr0 is available.

### usage

--privileged and --net=host is required to use KVM and virbr0 from Docker container.
```
docker pull syuu1228/osv-in-docker:latest
docker run --privileged --net=host -i -t syuu1228/osv-in-docker /bin/bash
```
