# podman-openwrt-builder

This project builds openwrt images according to the profiles listed in ```profiles```   
You'd obviously need to modify ```Dockerfile``` ```build.scripts/01-build.openwrt.sh``` and the profiles to suit your needs   


**Fedora package install**
```
dnf install podman python3-podman python3-termcolor   
```

**build openwrt image(s) according to the profile(s) listed in ```profiles```**
```
# this will build the image and run the container   
./script-podman.py

# login to the container 
podman exec -it openwrt_builder /bin/bash

# once inside the container, run this script to build an openwrt image for each profile
/root/scripts/01-build.openwrt.sh

# the resulting openwrt image(s) will be copied to the /output directory which is shared with the host system

# exit container
Control+D or exit
```

**script-podman.py options**  
these should be pretty self-explanatory
```
usage: script-podman.py [-h] [--auto] [--debug]
                        [--rebuild | --rerun | --restart | --rm_image | --rm_container | --stop_container]

options:
  -h, --help        show this help message and exit
  --auto            ensure image is built, then run container_script in a non-interactive container
  --debug           display debug messages
  --rebuild         remove podman image and container if they exist, then build (new) podman image and run container
  --rerun           remove container if it exists, then (re-)run it
  --restart         stop the container if it exists, then (re-)run it
  --rm_image        remove podman image and container if they exist
  --rm_container    remove container if it exists
  --stop_container  stop podman container it exists and is running
```
