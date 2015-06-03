# ansible-tomcat

Install Tomcat with configurable Catalina instances.

## Compatibility

### 0.8.0

Starting with this role version managing instances has been changed
significantly, mostly to better support capabilities from Systemd
(e.g. templated services).
Updating the role requires to reconfigure inventory. So please be
aware of ``tomcat_instances`` documentation below.


## Requirements

This role requires local facts in */etc/ansible/facts.d/java.fact*
to be available. The following variable must be available for the
default service templates to work:

* ``java_home``

Facts are used as

* ``ansible_local.java.general.java_home``

[groover.java](https://github.com/silpion/ansible-java) role may get
used to automatically fulfill the requirements.


## Dependencies

This role depends on ``groover.util`` role. This is configured
for ``ansible-galaxy install`` in **requirements.yml**.

**NOTE**: Requirements are installed as virtual user ``silpion``
(``silpion.util``).

Be sure to install required roles with

    ansible-galaxy install --role-file requirements.yml

* [groover.util](https://github.com/silpion/ansible-util)


## Role variables

* ``tomcat_version``: Configure Tomcat version (string, default: ``7.0.62``)
* ``tomcat_mirror``: Configure Tomcat mirror site (string, default: ``http://archive.apache.org/dist/tomcat``)
* ``tomcat_download_url``: Configure complete URL to download Tomcat from (string, default: ``{{ tomcat_mirror }}/tomcat-{{ tomcat_version_major }}/v{{ tomcat_version }}/bin/{{ tomcat_redis_filename }}``)
* ``tomcat_install_base``: Configure base/installation directory for Tomcat (string, default: ``/opt/tomcat``)
* ``tomcat_default_user_group``: Default group for the user account to run Tomcat as when not configured per instance (string, default: ``tomcat``)
* ``tomcat_default_user_name``: Default user account to run Tomcat as when not configured per instance (string, default: ``tomcat``)
* ``tomcat_default_user_home``: Default home directory for the user account to run Tomcat as when not configured per instance (string, default: ``/srv/{{ tomcat_default_user_name }}``)
* ``tomcat_instances``: Configure Catalina instances (list, default: ``{ - name: tomcat }``)
* ``tomcat_default_server_xml_template``: Default server.xml template to use for configuring Tomcat instances (string, default: ``server.xml.j2``
* ``tomcat_default_port_ajp``: Default AJP port when not configured per instance (int, default: ``8009``)
* ``tomcat_default_port_connector``: Default connector port when not configured per instance (int, default: ``8080``)
* ``tomcat_default_port_redirect``: Default redirect port when not configured per instance (int, default: ``8443``)
* ``tomcat_default_port_shutdown``: Default shutdown port when not configured per instance (int, default: ``8005``)
* ``tomcat_server_systemd_template``: Default template to use when configuring Tomcat for Systemd (string, default: ``service_systemd.j2`` (see ``vars/service/systemd.yml``))
* ``tomcat_server_sysvinit_template``: Default template to use when configuring Tomcat for SysV (string, default: ``service_sysvinit.j2`` (see ``vars/service/sysvinit.yml``))
* ``tomcat_server_upstart_template``: Default template to use when configuring Tomcat for upstart (string, default: ``service_upstart.j2`` (see ``vars/service/upstart.yml``))
* ``tomcat_service_allow_restart``: Whether to allow or deny restarting Tomcat instances automatically (boolean, default: ``true``)

### tomcat_instances

Instance configuration default variables may get configured per
instance. The following variables are legit to configure per instance.

* ``group``: Group for the user to run Tomcat instance as (string, default: ``{{ tomcat_default_user_group }}``)
* ``user``: User to run Tomcat instance as (string, default: ``{{ tomcat_default_user_name }}``)
* ``home``: Home directory for the user to run Tomcat instance as (string, default: ``{{ tomcat_default_user_home }}``)
* ``service_template``: Configure service template to use for a specific instance (string, default: ``{{ tomcat_default_service_template }}`` (see ``vars/service/*.yml``))
* ``server_xml_template``: server.xml template to use for configuring Tomcat instance (string, default: ``{{ tomcat_default_server_xml_template }}``)
* ``port_ajp``: Instance AJP port (int, default: ``{{ tomcat_default_port_ajp }}``)
* ``port_connector``: Instance connector port (int, default: ``{{ tomcat_default_port_connector }}``)
* ``port_redirect``: Instance redirect port (int, default: ``{{ tomcat_default_port_redirect }}``)
* ``port_shutdown``: Instance shutdown port (int, default: ``{{ tomcat_default_port_shutdown }}``)
* ``catalina_opts``: Instance CATALINA_OPTS environment variable configuration (string, default: ``''``)
* ``service_file``: Init system configuration file per instance, e.g. tomcat.conf for Upstart (string, default: ``{{ tomcat_default_service_file }}`` (see ``vars/service/*.yml``))
* ``service_name``: Init system service name per instance, e.g. tomcat@foo.service for Systemd (string, default: ``{{ tomcat_default_service_name }}`` (see ``vars/service/*.yml``))
* ``umask``: Allow to configure umask for Tomcat instance (oct, default: ``|default('')``)
* ``systemd_default_instance``: Allow to configure default instance for Systemd templated service (string, default: ``None`` }}

Configuring more than one instance requires to configure some of the
variables documented above per instance. Please see example playbooks
below.

## Versioned variables

Predefined SHA sums and further version specific configuration may get
found in the *vars/versions* directory. When configuring a version,
that is not predefined (so far), the following variables must also be
defined in the playbook/inventory:

* ``tomcat_redis_sha256sum``: SHA256 sum for the downloaded Tomcat redistributable package (string, default: ``a787ea12e163e78ccebbb9662d7da78e707aef051d15af9ab5be20489adf1f6d``)

## Systemd configuration

Configuring Systemd uses templated services by default. This allows to
have Tomcat instances managed with Systemd in the same system slice.
By default this role installs one service ``tomcat@tomcat.service``.

This makes it particularly not easy to add Systemd UMask= or
DefaultInstance= configuration. **If** there is more than one instance
configured with ``tomcat_instances`` to run as the same user, there
will be **ONE** service file /etc/systemd/system/USER@.service.

This behaviour can get overridden by configuring

* item.``service_file`` (e.g. ``tomcat-foo.service`` (/etc/systemd/system/tomcat-foo.service))
* item.``service_name`` (e.g. ``tomcat-bar`` (/etc/systemd/system/multi-user.target.wants/tomcat-bar.service))

per Systemd managed Tomcat instance. service_name here is the name
addressed as per systemctl restart *service_name*, service_file is
the file written by template: module to /etc/systemd/system/*service_file*.


## Example playbook

This playbook will install ONE tomcat instance with default configuration
as suggested upstream.

Tomcat will get installed to /opt/tomcat/apache-tomcat-{{ tomcat_version }}
as CATALINA_HOME. Default instance ``tomcat`` will get installed in
/srv/tomcat/catalina/tomcat as CATALINA_BASE.

The following services will get installed based on init system:

* Systemd: ``/etc/systemd/system/tomcat@.service`` (``systemctl ... tomcat@tomcat.service``)
* SysV: ``/etc/init.d/tomcat`` (``service tomcat ...``)
* Upstart: ``/etc/init/tomcat.conf`` (``service tomcat ...``)

<!-- -->

    ---
    - hosts: tomcat_server
      roles:
        - { role: ansible-tomcat }


This playbook installs two Tomcat instances targeted on a Systemd
enabled node running as the same user 'tomcat'.

Tomcat instances ``foo`` and ``bar`` will get installed in
/srv/tomcat/catalina/foo and /srv/tomcat/catalina/bar as CATALINA_BASE.

Both instances share system-tomcat.slice.

* ``systemctl ... tomcat@foo.service``
* ``systemctl ... tomcat@bar.service``

<!-- -->

    ---
    - hosts: tomcat_server
      vars:
        tomcat_instances:
          - name: foo
            service_name: tomcat@foo
            port_ajp: 18009
            port_connector: 18080
            port_redirect: 18443
            port_shutdown: 18005
          - name: bar
            service_name: tomcat@bar
            port_ajp: 28009
            port_connector: 28080
            port_redirect: 28443
            port_shutdown: 28005
      roles:
        - { role: ansible-tomcat }


The same playbook targeted on an Ubuntu server with Upstart.

* ``service tomcat-foo ...``
* ``service tomcat-bar ...``

<!-- -->

    ---
    - hosts: tomcat_server
      vars:
        tomcat_instances:
          - name: foo
            service_name: tomcat-foo
            service_file: tomcat-foo.conf
            port_ajp: 18009
            port_connector: 18080
            port_redirect: 18443
            port_shutdown: 18005
          - name: bar
            service_name: tomcat-bar
            service_file: tomcat-bar.conf
            port_ajp: 28009
            port_connector: 28080
            port_redirect: 28443
            port_shutdown: 28005
      roles:
        - { role: ansible-tomcat }


Running two Tomcat instances with different users targeted on a SysV
enabled system, e.g. RHEL6.

* ``service tomcat-foo ...``
* ``service tomcat-bar ...``

<!-- -->

    ---
    - hosts: tomcat_server
      vars:
        tomcat_instances:
          - name: foo
            user: tomcatfoo
            group: tomcatfoo
            home: /srv/tomcatfoo
            service_name: tomcat-foo
            service_file: tomcat-foo
            port_ajp: 18009
            port_connector: 18080
            port_redirect: 18443
            port_shutdown: 18005
          - name: bar
            user: tomcatbar
            group: tomcatbar
            home: /srv/tomcatbar
            service_name: tomcat-bar
            service_file: tomcat-bar
            port_ajp: 28009
            port_connector: 28080
            port_redirect: 28443
            port_shutdown: 28005
      roles:
        - { role: ansible-tomcat }


The same playbook targeted on a Systemd enabled node.

* ``systemctl ... tomcatfoo@tomcat.service``
* ``systemctl ... tomcatbar@tomcat.service``

<!-- -->

    ---
    - hosts: tomcat_server
      vars:
        tomcat_instances:
          - name: foo
            user: tomcatfoo
            group: tomcatfoo
            home: /srv/tomcatfoo
            service_name: foo@tomcat
            service_file: foo@.service
            port_ajp: 18009
            port_connector: 18080
            port_redirect: 18443
            port_shutdown: 18005
          - name: bar
            user: tomcatbar
            group: tomcatbar
            home: /srv/tomcatbar
            service_name: bar@tomcat
            service_file: bar@.service
            port_ajp: 28009
            port_connector: 28080
            port_redirect: 28443
            port_shutdown: 28005
      roles:
        - { role: ansible-tomcat }


The same playbook without sharing Systemd system slice.

* ``systemctl ... tomcatfoo.service``
* ``systemctl ... tomcatbar.service``

<!-- -->

    ---
    - hosts: tomcat_server
      vars:
        tomcat_instances:
          - name: foo
            user: tomcatfoo
            group: tomcatfoo
            home: /srv/tomcatfoo
            service_name: tomcatfoo
            service_file: tomcatfoo.service
            port_ajp: 18009
            port_connector: 18080
            port_redirect: 18443
            port_shutdown: 18005
          - name: bar
            user: tomcatbar
            group: tomcatbar
            home: /srv/tomcatbar
            service_name: tomcatbar
            service_file: tomcatbar.service
            port_ajp: 28009
            port_connector: 28080
            port_redirect: 28443
            port_shutdown: 28005
      roles:
        - { role: ansible-tomcat }


Defaults? I don't like defaults on my Ubuntu server. I'll override
all the defaults!

* ``service motcat ...``

<!-- -->

    ---
    - hosts: tomcat_server
      vars:
        tomcat_version: 8.0.5
        tomcat_install_base: /srv
        tomcat_default_user_name: xyz
        tomcat_default_user_group: zyx
        tomcat_default_user_home: /var/home/xyz
        tomcat_default_server_xml_template: myveryownserverxmltemplate.j2
        tomcat_default_port_ajp: 12345
        tomcat_default_port_connector: 12346
        tomcat_default_port_redirect: 12347
        tomcat_default_port_shutdown: 12348
        tomcat_default_upstart_template: myveryownupstarttemplate.j2
        tomcat_service_allow_restart: false
        tomcat_instances:
          - name: nodefaults
            service_name: motcat
            service_file: motcat.conf
            catalina_opts: '-Dwhatever'
            umask: 0002
      roles:
        - { role: ansible-tomcat }


Defaults again? I still don't like defaults on my CentOS 7 server. I'll
override all the configuration but focus on instance configuration.

* ``systemctl ... motcat.service``

<!-- -->

    ---
    - hosts: tomcat_server
      vars:
        tomcat_version: 8.0.5
        tomcat_install_base: /srv
        tomcat_service_allow_restart: false
        tomcat_instances:
          - name: nodefaults
            user: xyz
            group: zyx
            home: /var/home/xyz
            service_template: myveryownsystemdtemplate.j2
            server_xml_template: myveryownserverxmltemplate.j2
            port_ajp: 12345
            port_connector: 12346
            port_redirect: 12347
            port_shutdown: 12348
            service_name: motcat
            service_file: motcat.service
            catalina_opts: '-Dwhatever'
            umask: 0002
      roles:
        - { role: ansible-tomcat }


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

* Mark Kusch @mark.kusch silpion.de
* Marc Rohlfs @marc.rohlfs silpion.de


### Contributors

* Lars Maehlmann @lars.maehlmann silpion.de
* Sebastian Davids @sebastian.davids silpion.de
* [trumant](https://github.com/trumant)
* [kakawait](https://github.com/kakawait)


<!-- vim: set ts=4 sw=4 et nofen: -->
