# 2.2.0

Anja Siek (10):

* reuse generator
* fix includes
* fix geturl deprication
* use variable for path\_to\_lib\_role
* update documentation
* update default-lib path and fix tests
* add default-var from lib-role
* fix documentaqtion
* update documentation
* set default of default

Georg Hopp (8):

* Add variable to control IPv4 behavior
* Document new variable
* Use new variable in systemd startup
* Use new variable in sysvinit startup
* Use new variable in upstart startup
* Per instance IPv4 preference setting
* fix previously forgotten variable rename in template
* fix if else oder for service upstart

Mark Kusch (4):

* Update default tomcat version to 8.0.37
* Fix trailing whitespace in facts template
* Add vendor data to facts and updates tests
* Remove vagrant hack for ssh insecure key replacement

# 2.1.0

Mark Kusch (4):

* Stop tomcat at the latest point possible for upgrade installations
* Do not run java role in all test plays
* Remove leftovers from testing with parameterised includes
* Update test depndencies

Anja Siek (1):

* implement update installation tasks; fix warnings

Alvaro Aleman (4):

* Rerun generator
* Add documentation about catalina\_home \_base
* Avoid implicit upgrades when an older version of Tomcat is already installed
* Add a test to ensure Tomcat doesnt get implicitly upgraded

# 2.0.1

Mark Kusch (1):

* Fix dependency management

# 2.0.0

Alvaro Aleman (2):

* Make util include v2 compatible
* Re-run generator

Marc Rohlfs (5):

* Install ROOT webapp in test Tomcat instances.
* Changed assignments to complex args style.
* Vagrant VM should always forward the Tomcat default port.
* Applied style guide to boolean literals.
* Fixed wrong variable usage.

Mark Kusch (6):

* Use lib role for managing assets
* Min Ansible version is now 2.N
* Add support for initial and succeeding check mode applications
* "Debug command in PR? :)))"
* Ensure check mode functions properly on initial application
* Fix initial check mode detection

# 1.3.0

Mark Kusch (9):

* Conform to current style guide
* Re-run generator
* Adapt generated updates for vagrant to centos test environments
* Allow to manage a tomcat instances web.xml
* Add new 7.0.x versions and update default to current latest 7.0.65 (thx to PhysicsUnplugged)
* Add variables for tomcat 8.0.29
* Update default tomcat installation to tomcat 8 (8.0.29)

# 1.2.0

Mark Kusch (5):

* Allow to configure tomcat URI encoding
* Use override mechanic for URI encoding
* Add support for RHEL as a distribution
* Adapt documentation to override mechanic for URI encoding
* Add role version to facts

# 1.1.1

Mark Kusch (1):

* Ensure PID file with default SysV service

# 1.1.0

Mark Kusch (4):

* Fix user to run tomcat as with SysV default service template
* [ansible-generator] Do not store .retry files when testing this role
* Allow to add environment files for vagrant based development
* Add vagrant environments for CentOS 6 and 7

kakawait (3):

* add missing catalina\_base directories: bin, lib and work
* Update README.md to add new option: tomcat\_facts\_template
* use JSON format for facts.j2 template and expose some instances configurations inside facts

# 1.0.0

Mark Kusch (1):

* [Fix] Allow to globaly configure service templates

# 0.9.0

Deepan (1):

* Introduced a new variable to configure instance path to be different from the user home + fixed temp dir path issue within service\_systemd.j2

# 0.8.0

Marc Rohlfs (1):

* Add missing port forwarding for Vagrant VM

Mark Kusch (32):

* Configure dependency on util role
* Document dependency on util role
* Ensure service management with handlers
* Use util role for downloading and uploading assets
* Allow SysV init to stop the tomcat service (thx to kakawait)
* Do not generate changed events when registering configuration files
* s/sudo/become/g
* Add sha sum for tomcat 8.0.21
* Add versioned vars for tomcat 8.0.22
* Add support for tomcat 7.0.62
* Default to tomcat version 7.0.62
* Re-create infrastructure for init/service configuration
* Final service management abstraction
* Proper variable naming
* Proper detection for init system with CentOS
* Fix systemd template
* Be more precise with supported platforms/distributions
* Update description for Archlinux init system vars
* init system var is now managed with util role
* Ensure java role is including when developing the role
* Allow travis to install test dependencies
* Fix Systemd name in documentation
* Change the way instances are managed
* Update documentation for new instance management
* Stay consistent with variable naming for registered vars
* Re-integrate configurable service template per instance
* Fix non-templated systemd services
* More documentation for different tomcat installation styles
* Move test requirements to tests/ directory
* Provide global default variable to configure CATALINA\_OPTS

# 0.7.1

Mark Kusch (1):

* Fix variable substitution when installing service for SysV

# 0.7.0

Travis Truman (1):

* Allow customization of installer download url for local artifact repositories, etc

Mark Kusch (2):

* Add documentation for tomcat_download_url variable
* Add contribution information to documentation

# 0.6.0

Mark Kusch (2):

* Fix usage for sysv init script

Travis Truman (1):

* Ability to customize Upstart, SystemD and SysVInit service configuration by providing alternate templates

# 0.5.2

Sebastian Davids (1):

* FIX - hard coded service name

# 0.5.1

Mark Kusch (1):

* Ensure tasks define sudo: yes when requiring superuser privileges

# 0.5.0

Mark Kusch (6):

* Fix documentation for java local facts (github/issues#1)
* Update tomcat to version 7.0.57
* Use ansible local facts for java_home in any system service management template
* Update integration testing to work with Serverspec 2.N
* Allow github to perform integration testing
* Abstract supported platforms in vars

# 0.4.5

Marc Rohlfs (1):

* Optionally set umask for Tomcat service.

# 0.4.4

Marc Rohlfs (2):

* Configure variable 'tomcat_env_catalina_opts' (with empty default value). Arguments for remote debugging now have to be defined out side of the tomcat role. This provides full flexibility to define the transport options for remote debugging as well as all other possible options that may be passed to the JVM on startup.
* Install server.xml using a template that can be overwritten in the playbooks.

# 0.4.3

Marc Rohlfs (1):

* Removed leftovers of removed 'tomcat_base_port' var.

# 0.4.2

Mark Kusch (3):

* Fixup vars and defaults
* Persist tomcat configuration
* Update documentation to current state of variable management

# 0.4.1

Marc Rohlfs (1):

* Enable and configure remote debugging.

# 0.4.0

Marc Rohlfs (6):

* Predefined, overwritable version data.
* Changed default version to latest published version.
* Improved default variables for Tomcat service user, installation and instance. Now, 'tomcat_user_home' and 'tomcat_env_catalina_base' don't need to be defined per Tomcat instance, because the default definitions implicitly set different values.
* Default variable 'tomcat_service_name' is now configured with the value of the variable 'tomcat_user_name', so that it doesn't need to be defined per Tomcat instance.
* Allow optional configuration of a base value for all the port that have to be defined for a Tomcat instance.
* Warning and qualified informaiton on port configurations.

# 0.3.0

Marc Rohlfs (12):

* Improved patterns for files to be ignored by Git
* Applied variable names for service user to new style guide.
* New variables for ansible-tomcat role: - 'tomcat\_env\_catalina\_base' points to the tomcat instance directory. - 'tomcat\_env\_catalina\_home' points to the tomcat installation directory.
* Properly distinguish installtion and instance files.
* Fixed wrong usage of vars 'tomcat\_env\_catalina\_home' and 'tomcat\_env\_catalina\_base'.
* Fixed task definition style: orgsanised meta data before module.
* Added documentation for variable 'tomcat_catalina_base_conf_files'.
* Always copy all conf files from the Tomcat installation to the Tomcat instance without enabling the user to define which files to be copied.
* Allow configuration of ports for Tomcat service.
* Parameterise service, notifications and handlers with service name to enable multiple role invocations within one playbook.
* Moved default definition of 'tomcat_env_catalina_base' to the 'tomcat instance' section.
* Documentation how to invoke the role to install, configure and run multiple Tomcat instances within one playbook.

Mark Kusch (1):

* Update ubuntu-upstart-sshkey container to version 1.0.0

# 0.2.0

Mark Kusch (3):

* Update variables documentation
* Update to current mechanics for ansible roles
* ansible-generator: Add integration test infrastructure

# 0.0.1

* Initial commit


<!-- vim: set nofen ts=4 sw=4 et: -->
