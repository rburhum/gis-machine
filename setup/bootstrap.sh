#!/bin/bash

if [ -f ~/.bootstrap_complete ]; then
    exit 0
fi

set -x

# do all system updates
sudo apt-get update -y

# force upgrade of packages and force it to not be interactive
sudo DEBIAN_FRONTEND=noninteractive apt-get -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" dist-upgrade

# install add-apt-repository script
sudo apt-get install python-software-properties -y

# add Ubuntu GIS repo (for some reason it needs a full path)
sudo add-apt-repository ppa:ubuntugis/ubuntugis-unstable -y

# force updates with new repo
sudo apt-get update -y
sudo apt-get dist-upgrade -y

# make sure dependencies are installed
sudo apt-get install python-setuptools python-dev build-essential python-pip \
build-essential openjdk-6-jre openjdk-6-jdk postgresql git python-software-properties proj libproj-dev \
python-pip python-virtualenv python-dev virtualenvwrapper gdal-bin libgdal1-dev curl python-gdal \
postgresql-server-dev-9.1 postgresql-9.1-postgis-2.0 postgresql-contrib-9.1 \
postgresql-client-9.1 postgresql-client-common postgresql-doc-9.1 -y

# force updates with new repo
sudo apt-get dist-upgrade -y
sudo apt-get autoremove -y

# convenience tools
sudo apt-get install vim -y

# from this point on, nothing should fail
set +e

# create dbuser user and dbuser-db database
sudo su postgres -c "createuser --superuser --createdb dbuser"
sudo -u postgres psql -c "ALTER USER dbuser WITH PASSWORD 'dbuser'"
sudo su postgres -c "createdb dbuser"
sudo su postgres -c "createdb -O dbuser dbuser-db"
export PGPASSWORD='dbuser'
psql -U dbuser -h 127.0.0.1 dbuser-db -c 'create extension postgis'

# Since the vagrant file creates a port forward for postgres, we
# need to tell postgres that we should allow to do md5 authentication
# from the VirtualBox internal network and to listen for authentication
# from all ips
echo "host    all             all             10.0.2.1/24            md5" | sudo tee -a /etc/postgresql/9.1/main/pg_hba.conf
sudo sed -i "s/#listen_addresses.*/listen_addresses = '\*'/g"  /etc/postgresql/9.1/main/postgresql.conf
sudo /etc/init.d/postgresql restart

# Add work around for PIL problems on Ubuntu
# This is needed so that when we install PIL, it will find the lib file and add
# png / zlib support
sudo ln -s /usr/lib/x86_64-linux-gnu/libz.so /usr/lib/

# install python dependencies
cd /gistools/setup
sudo pip install -r pip-req.txt

# we did it. let's mark the script as complete
touch ~/.bootstrap_complete
