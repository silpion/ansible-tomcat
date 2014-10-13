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
* ``tomcat_user_home``: Configure home directory for Tomcat service user (default: ``/srv/{{ tomcat_user_name }}``)
* ``tomcat_install_base``: Configure base/installation directory for Tomcat (default: ``/opt/tomcat``)
* ``tomcat_env_catalina_home``: Configure environment variable that points to the tomcat installation directory (default: ``{{ tomcat_install_base }}/apache-tomcat-{{ tomcat_version }}``)
* ``tomcat_env_catalina_base``: Configure environment variable that points to the tomcat instance directory (default: ``{{ tomcat_user_home }}/catalina``)
* ``tomcat_service_name``: Configure name for Tomcat service (default: ``tomcat``)
* ``tomcat_connector_port``: Configure connector port for Tomcat service (default: ``8080``)
* ``tomcat_redirect_port``: Configure redirect port for Tomcat service (default: ``8443``)
* ``tomcat_shutdown_port``: Configure shutdown port for Tomcat service (default: ``8005``)
* ``tomcat_ajp_port``: Configure AJP port for Tomcat service (default: ``8009``)

### Role variables for multiple role invocations

The role can be invoked multiple times in one playbook to support the maintenance
of multiple Tomcat instances with one single installation - like documented in
[Running The Apache Tomcat 7.0](http://tomcat.apache.org/tomcat-7.0-doc/RUNNING.txt),
section *Advanced Configuration - Multiple Tomcat Instances*. To achieve this, the
role must be invoked once for each desired instance and parameterised with a number
of variables that **must** differ in each role invocation:

* ``tomcat_user_name``
* ``tomcat_user_group``
* ``tomcat_user_home`` (implicitly differs when default definition is not overwritten)
* ``tomcat_env_catalina_base`` (implicitly differs when default definition is not overwritten)
* ``tomcat_service_name``
* ``tomcat_connector_port``
* ``tomcat_redirect_port``
* ``tomcat_shutdown_port``
* ``tomcat_ajp_port``

## Dependencies

None.

## Example playbook

    ---
    - hosts: tomcat_server
      roles:
        - { role: ansible-tomcat }

### Example playbook for multiple role invocations

    ---
    - hosts: tomcat_server
      roles:
        - { role: ansible-tomcat,
              tomcat_user_name: "{{ tomcat_user_name_instance1 }}",
              tomcat_user_group: "{{ tomcat_user_group_instance1 }}",
              tomcat_service_name: "{{ tomcat_service_name_instance1 }}",
              tomcat_connector_port: "{{ tomcat_connector_port_instance1 }}",
              tomcat_redirect_port: "{{ tomcat_redirect_port_instance1 }}",
              tomcat_shutdown_port: "{{ tomcat_shutdown_port_instance1 }}",
              tomcat_ajp_port: "{{ tomcat_ajp_port_instance1 }}"
          }
        - { role: ansible-tomcat,
              tomcat_user_name: "{{ tomcat_user_name_instance2 }}",
              tomcat_user_group: "{{ tomcat_user_group_instance2 }}",
              tomcat_service_name: "{{ tomcat_service_name_instance2 }}",
              tomcat_connector_port: "{{ tomcat_connector_port_instance2 }}",
              tomcat_redirect_port: "{{ tomcat_redirect_port_instance2 }}",
              tomcat_shutdown_port: "{{ tomcat_shutdown_port_instance2 }}",
              tomcat_ajp_port: "{{ tomcat_ajp_port_instance2 }}"
          }

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
