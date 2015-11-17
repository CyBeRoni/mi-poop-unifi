#!/bin/bash

# This script was tested with 4.7.6 so get that by default
unifiversion=$(mdata-get unifi:version || echo '4.7.6')

pushd /tmp
wget http://dl.ubnt.com/unifi/${unifiversion}/UniFi.unix.zip
popd
pushd /opt/local
unzip /tmp/UniFi.unix.zip

rm UniFi/bin/mongod
ln -s /opt/local/bin/mongod UniFi/bin/mongod

test -d /srv/unifi/data || mkdir -p /srv/unifi/data && chown unifi /srv/unifi/data
test -d /srv/unifi/run || mkdir -p /srv/unifi/run && chown unifi /srv/unifi/run

ln -s /srv/unifi/data /opt/local/UniFi/data
ln -s /var/log/run /opt/local/UniFi/run

mkdir /opt/local/UniFi/{logs,work} && chown unifi /opt/local/UniFi/{logs,work}

popd

svccfg import /opt/local/lib/svc/manifest/unifi.xml
svcadm enable svc:/network/unifi:default


