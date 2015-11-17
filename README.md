mi-poop-unifi
=============

Please refer to https://github.com/joyent/mibe for use of this repo.

Use with base-64 image from Joyent; tested with 15.3.0.

When built, this image provides the Ubiquiti UniFi controller webapp.

Metadata
---------
The following customer_metadata is used:

* system:ssh_disabled - Whether or not to disable the ssh daemon (default: false)
* system:timezone - What timezone to use (no default)
* unifi:version - What version of UniFi to install (default: 4.7.6)

Services
--------
When running, the following services are exposed to the network on both IPv4 and IPv6:

* All unifi ports, most importantly 8080 and 8443; see unifi documentation for which ports do what.
* 22: SSH (if not disabled)


Data
----
This image requires a delegated dataset, on which the unifi controller data is saved.

Upgrading
---------
To avoid distributing the unifi software, the license for which is unclear, this image downloads the software from Ubiquiti upon provision. 
This makes it possible to upgrade the software by changing the 'unifi:version' metadata item and reprovisioning. 


Example JSON
------------

    {
      "brand": "joyent",
      "image_uuid": "",
      "alias": "unifi",
      "hostname": "unifi",
      "dns_domain": "poop.nl",
      "max_physical_memory": 512,
      "cpu_shares": 100,
      "quota": 5,
      "delegate_dataset": "true",
      "nics": [
        {
          "nic_tag": "admin",
          "ips": ["1.2.3.4/24", "2001::1/64"],
          "gateways": ["1.2.3.1"],
          "primary": "true"
        }
      ],
      "resolvers": [
        "8.8.8.8",
        "8.8.4.4"
      ],
      "customer_metadata": {
        "system:ssh_disabled": "true",
        "system:timezone": "Europe/Amsterdam",
	"unifi:version": "4.7.6"
      }
    }
