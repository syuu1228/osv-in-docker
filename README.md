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

### Usage of the container
```
source /etc/profile.d/rvm.sh # For OSv/Ruby
rvm use 2.2.0                # For OSv/Ruby

cd /root/osv
ls apps # choose your favorite app
./scripts/build image=tomcat,httpserver # pass app name following "image="
                                        # Multiple apps can specify by using camma,
                                        # "httpserver" is system module that provides REST api and Web interface.
./scripts/run.py -n # run built VM image on KVM
```


