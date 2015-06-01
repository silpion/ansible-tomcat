# ansible-tomcat

Install the latest version of Tomcat.

## Requirements

This role requires local facts in */etc/ansible/facts.d/java.fact*
to be available. The following variable must be available for the
upstart service template to work:

* ``java_home``

Facts are used as

* ``ansible_local.java.general.java_home``

## Role variables

* ``tomcat_version``: Configure Tomcat version (string, default: ``7.0.57``)
* ``tomcat_mirror``: Configure Tomcat mirror site (string, default: ``http://archive.apache.org/dist/tomcat``)
* ``tomcat_redis_sha256sum``: SHA256 sum for the downloaded Tomcat redistributable package (string, default: ``c0ca44be20bccebbb043ccd7ab5ea4d94060fdde6bb84812f3da363955dae5bb``)
* ``tomcat_install_base``: Configure base/installation directory for Tomcat (string, default: ``/opt/tomcat``)

### Tomcat instance variables

This role can be invoked multiple times in one playbook to support the maintenance
of multiple Tomcat instances with one single installation - like documented in
[Running The Apache Tomcat 7.0](http://tomcat.apache.org/tomcat-7.0-doc/RUNNING.txt),
section *Advanced Configuration - Multiple Tomcat Instances*. To achieve this, the
role must be invoked once for each desired instance and parameterised with a number
of variables that **must** differ in each role invocation:

* ``tomcat_user_name``: Configure user to run Tomcat as (string, default: ``tomcat``)
* ``tomcat_user_group``: Configure group for Tomcat service user (string, default: ``tomcat``)
* ``tomcat_user_home``: Configure home directory for Tomcat service user (string, default: ``/srv/{{ tomcat_user_name }}``)
* ``tomcat_download_url``: Where to download Tomcat from (string, default: ``{{ tomcat_mirror }}/tomcat-{{ tomcat_version_major }}/v{{ tomcat_version }}/bin/{{ tomcat_redis_filename }}``)
* ``tomcat_env_catalina_base``: Configure environment variable that points to the tomcat instance directory (string, default: ``{{ tomcat_user_home }}/catalina``)
* ``tomcat_env_catalina_opts``: Configure environment variable specifying additional options for the Java command that starts Tomcat (string, default: None)
* ``tomcat_service_name``: Configure name for Tomcat service (string, default: ``{{ tomcat_user_name }}``)
* ``tomcat_service_umask``: Configure umask (just the 4 digit value) for Tomcat service (string, default: None)
* ``tomcat_server_xml_template``: Configure path to template for Tomcat configuration file _server.xml_ (string, default: ``server.xml.j2``)
* ``tomcat_server_systemd_template``: Configure path to template for Tomcat Systemd config _tomcat.service_ (string, default: ``service_systemd.j2``)
* ``tomcat_server_sysvinit_template``: Configure path to template for Tomcat sysvinit config _tomcat_ (string, default: ``service_sysvinit.j2``)
* ``tomcat_server_upstart_template``: Configure path to template for Tomcat Upstart config _tomcat.conf_ (string, default: ``service_upstart.j2``)


Tomcat instances must get configured with different ports in your inventory/playbook.
Defaults for these ports are not accessable as variables but are used with jinja |default()
function in tasks/main.yml.

* ``tomcat_connector_port``: Configure connector port for Tomcat service (int, default: ``8080``)
* ``tomcat_redirect_port``: Configure redirect port for Tomcat service (int, default: ``8443``)
* ``tomcat_shutdown_port``: Configure shutdown port for Tomcat service (int, default: ``8005``)
* ``tomcat_ajp_port``: Configure AJP port for Tomcat service (int, default: ``8009``)

## Dependencies

This role depends on ``groover.util`` role. This is configured
for ``ansible-galaxy install`` in **requirements.yml**.

**NOTE**: Requirements are installed as virtual user ``silpion``
(``silpion.util``).

Be sure to install required roles with

    ansible-galaxy install --role-file requirements.yml

* [groover.util](https://github.com/silpion/ansible-util)

## Example playbook

    ---
    - hosts: tomcat_server
      roles:
        - { role: ansible-tomcat }

### Example playbook for multiple role invocations

    ---
    - hosts: tomcat_server
      vars:
        - tomcat_user_name_instance_1: foo
        - tomcat_user_group_instance_1: foo
        - tomcat_connector_port_instance_1: 25080
        - tomcat_redirect_port_instance_1: 25443
        - tomcat_shutdown_port_instance_1: 25005
        - tomcat_ajp_port_instance_1: 25009
        - tomcat_env_catalina_opts_instance_1: "-agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=65321"
        - tomcat_service_umask_instance_1: "0002"
        - tomcat_server_xml_template_instance_1: "{{ playbook_dir }}/templates/server.xml.j2"
        - unrelated_other_variable: unrelated_value
        - tomcat_user_name_instance_2: bar
        - tomcat_user_group_instance_2: bar
        - tomcat_connector_port_instance_2: 22080
        - tomcat_redirect_port_instance_2: 22443
        - tomcat_shutdown_port_instance_2: 22005
        - tomcat_ajp_port_instance_2: 22009
        - tomcat_env_catalina_opts_instance_2: "-agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=62321"
        - tomcat_server_xml_template_instance_2: templates/server.xml.j2
      roles:
        - { role: ansible-tomcat,
              tomcat_user_name: "{{ tomcat_user_name_instance_1 }}",
              tomcat_user_group: "{{ tomcat_user_group_instance_1 }}",
              tomcat_connector_port: "{{ tomcat_connector_port_instance_1 }}",
              tomcat_redirect_port: "{{ tomcat_redirect_port_instance_1 }}",
              tomcat_shutdown_port: "{{ tomcat_shutdown_port_instance_1 }}",
              tomcat_ajp_port: "{{ tomcat_ajp_port_instance_1 }}",
              tomcat_env_catalina_opts: "{{ tomcat_env_catalina_opts_instance_1 }}",
              tomcat_service_umask: "{{ tomcat_service_umask_instance_1 }}",
              tomcat_server_xml_template: "{{ tomcat_server_xml_template_instance_1 }}"
          }
        - { role: ansible-tomcat,
              tomcat_user_name: "{{ tomcat_user_name_instance_2 }}",
              tomcat_user_group: "{{ tomcat_user_group_instance_2 }}",
              tomcat_connector_port: "{{ tomcat_connector_port_instance_2 }}",
              tomcat_redirect_port: "{{ tomcat_redirect_port_instance_2 }}",
              tomcat_shutdown_port: "{{ tomcat_shutdown_port_instance_2 }}",
              tomcat_ajp_port: "{{ tomcat_ajp_port_instance_2 }}",
              tomcat_env_catalina_opts: "{{ tomcat_env_catalina_opts_instance_2 }}",
              tomcat_server_xml_template: "{{ tomcat_server_xml_template_opts_instance_2 }}"
          }
        - { role: ansible-tomcat } # use default values here

## Contributing

If you want to contribute to this repository please be aware that this
project uses a [gitflow](http://nvie.com/posts/a-successful-git-branching-model/)
workflow with the next release branch called ``next``.

Please fork this repository and create a local branch split off of the ``next``
branch and create pull requests back to the origin ``next`` branch.

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
Marc Rohlfs @marc.rohlfs silpion.de

### Contributors

* Lars Maehlmann @lars.maehlmann silpion.de
* Sebastian Davids @sebastian.davids silpion.de
* [trumant](https://github.com/trumant)


<!-- vim: set ts=4 sw=4 et nofen: -->
