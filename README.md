# script_linux
Son script creados con el fin de automatizar algunos procesos en el sistema linux

## Run without Vagrant
### Clone the repository
```
git clone git@github.com:dave503/script_linux.git

```

### Move to the scripts directory
```
cd script_linux/
```

### Update list of apps available
```
./actualizar.sh
```

### Install git
```
./git_install.sh
```

### Install dns and create domains
```
./dns_install.sh
```

## Run with Vagrant

### Setup IP Address 
SERVER_IP=192.168.23.2

### Run vm in vagrant VM
```
vagrant up
```

### connect to vm
```
vagran ssh server
```

## Install git in vagrant vm
```
yum install -y git
```

Then in the vm you can clone and follow the instructions to run the scripts that you need.

If you want to contribute to this repo, fork it, make changes and send your PR.
Happy Hacking :)