# ansible-tomcat

Install the latest version of Tomcat.


## Role variables

* ``tomcat_version``: Configure Tomcat version (default: ``7.0.52``)
* ``tomcat_mirror``: Configure Tomcat mirror site (default: ``http://archive.apache.org/dist/tomcat``)
* ``tomcat_redis_sha256sum``: SHA256 sum for the downloaded Tomcat redistributable package (default: ``f5f3c2c8f9946bf24445d2da14b3c2b8dc848622ef07c3cda14f486435d27fb0``)
* ``tomcat_user``: Configure user to run Tomcat as (default: ``tomcat``)
* ``tomcat_group``: Configure group for Tomcat service user (default: ``tomcat``)
* ``tomcat_home``: Configure home directory for Tomcat service user (default: ``/srv/tomcat``)
* ``tomcat_base``: Configure base/installation directory for Tomcat (default: ``/opt/tomcat``)


# Requirements

None.

# Dependencies

None.


# Example playbook

    ---
    - hosts: tomcat_server
      roles:
        - { role: tomcat }


# License

Apache Version 2.0


# Author

Mark Kusch @mark.kusch silpion.de


<!-- vim: set ts=4 sw=4 et nofen: -->
