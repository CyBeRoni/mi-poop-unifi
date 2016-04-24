#!/bin/bash

# This script was tested with 4.8.15 so get that by default
unifiversion=$(mdata-get unifi:version || echo '4.8.15')

pushd /tmp
wget http://dl.ubnt.com/unifi/${unifiversion}/UniFi.unix.zip
popd
pushd /opt/local
unzip /tmp/UniFi.unix.zip

# Fix the symlink to mongod
rm UniFi/bin/mongod
ln -s /opt/local/bin/mongod UniFi/bin/mongod

# Drop in a new snappy which has native code and is now apparently required
rm UniFi/lib/snappy-java-1.0.5.jar
mv /root/snappy-java-1.1.2.4.jar UniFi/lib/snappy-java-1.0.5.jar

test -d /srv/unifi/data || mkdir -p /srv/unifi/data && chown unifi /srv/unifi/data
test -d /srv/unifi/run || mkdir -p /srv/unifi/run && chown unifi /srv/unifi/run

ln -s /srv/unifi/data /opt/local/UniFi/data
ln -s /var/log/run /opt/local/UniFi/run

mkdir /opt/local/UniFi/{logs,work} && chown unifi /opt/local/UniFi/{logs,work}

popd

svccfg import /opt/local/lib/svc/manifest/unifi.xml
svcadm enable svc:/network/unifi:default


