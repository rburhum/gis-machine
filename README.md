gis-machine
===========

An Ubuntu VirtualBox machine with GIS software installed (created through Vagrant). 

Included:

- Add the Ubuntu GIS repo.
  So you can do things like ```sudo apt-get install qgis```
  
  
- Sets up PostGIS. 
  User: dbuser Password: dbuser. In addition, it port forwards the VMs Postgresql/PostGIS port (5432) to the local machine's 5433 port so you can connect using your favorite sql client as if you were connecting to a locally-installed postgres. 

Example:

```bash
psql -U dbuser -W -h 127.0.0.1 -p 5433
```


With this you can:

1.- create a VirtualBox GIS machine with a single command:

```bash
vagrant up
```

2.- login into it with a single command:

```bash
vagrant ssh
```

3.- stop it with a single command:

```bash
vagrant halt
```

4.- destroy it with a single command:

```bash
vagrant destroy
```

Cool huh?

## Setup of GIS VirtualMachine

1.- Install Vagrant from the site http://www.vagrantup.com . I have tested it with ```Vagrant version 1.2.2```. Earlier versions are known to have problems.

2.- Install VirtualBox: https://www.virtualbox.org/wiki/Downloads . I have tested it with ```VirtualBox 4.2.12```. Earlier versions are known to have problems.

3.- Adjust the Vagrant configuration file ( ```Vagrantfile``` ) to reflect the location of your local data folder.

```bash
config.vm.synced_folder "/Users/rburhum/Data/navteq", "/data"
```

4.- Start vagrant

```bash
vagrant plugin install vagrant-vbguest
vagrant up
```

You are ready to go! You can now ssh into the VM which has the system already configured

 ```bash
 vagrant ssh
 ```
 


## Tips

1.- If using the VirtualBox option, you should be able to connect to the postgres machine using the port forwarding
that has already been configured. Connect using:

```bash
psql -U nvidia -W nvidia-maptools -h 127.0.0.1 -p 5433
```



