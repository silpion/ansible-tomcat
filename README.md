# ansible-tomcat

Install the latest version of Tomcat.

## Requirements

This role requires local facts in */etc/ansible/facts.d/java.fact*
to be available. The following variable must be available for the
upstart service template to work:

* ``java_home``

Facts are used as

* ``ansible_local.java.default.java_home``

## Role variables

* ``tomcat_version``: Configure Tomcat version (default: ``7.0.52``)
* ``tomcat_mirror``: Configure Tomcat mirror site (default: ``http://archive.apache.org/dist/tomcat``)
* ``tomcat_redis_sha256sum``: SHA256 sum for the downloaded Tomcat redistributable package (default: ``f5f3c2c8f9946bf24445d2da14b3c2b8dc848622ef07c3cda14f486435d27fb0``)
* ``tomcat_user_name``: Configure user to run Tomcat as (default: ``tomcat``)
* ``tomcat_user_group``: Configure group for Tomcat service user (default: ``tomcat``)
* ``tomcat_user_home``: Configure home directory for Tomcat service user (default: ``/srv/tomcat``)
* ``tomcat_install_base``: Configure base/installation directory for Tomcat (default: ``/opt/tomcat``)
* ``tomcat_env_catalina_home``: Configure environment variable that points to the tomcat installation directory (default: ``{{ tomcat_install_base }}/apache-tomcat-{{ tomcat_version }}``)
* ``tomcat_env_catalina_base``: Configure environment variable that points to the tomcat instance directory (default: ``{{ tomcat_user_home }}/catalina``)
* ``tomcat_catalina_base_conf_files``: Configure the files to be copied from ``$CATALINA_HOME/conf`` to ``$CATALINA_BASE/conf`` (optional; if not defined, all files will be copied).

## Dependencies

None.

## Example playbook

    ---
    - hosts: tomcat_server
      roles:
        - { role: ansible-tomcat }

## License

Apache Version 2.0

## Integration testing

This role provides integration tests using the Ruby RSpec/serverspec framework
with a few drawbacks at the time of writing this documentation.

- Currently supports ansible_os_family == 'Debian' only.

Running integration tests requires a number of dependencies being
installed. As this role uses Ruby RSpec there is the need to have
Ruby with rake and bundler available.

    # install role specific dependencies with bundler
    bundle install

<!-- -->

    # run the complete test suite with Docker
    rake suite

<!-- -->

    # run the complete test suite with Vagrant
    RAKE_ANSIBLE_USE_VAGRANT=1 rake suite

# Author information

Mark Kusch @mark.kusch silpion.de


<!-- vim: set ts=4 sw=4 et nofen: -->
