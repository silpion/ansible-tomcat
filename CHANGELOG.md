# 0.4.5

Marc Rohlfs (1):
      Optionally set umask for Tomcat service.

# 0.4.4

Marc Rohlfs (2):
      Configure variable 'tomcat_env_catalina_opts' (with empty default value). Arguments for remote debugging now have to be defined out side of the tomcat role. This provides full flexibility to define the transport options for remote debugging as well as all other possible options that may be passed to the JVM on startup.
      Install server.xml using a template that can be overwritten in the playbooks.

# 0.4.3

Marc Rohlfs (1):
      Removed leftovers of removed 'tomcat_base_port' var.

# 0.4.2

Mark Kusch (3):
      Fixup vars and defaults
      Persist tomcat configuration
      Update documentation to current state of variable management

# 0.4.1

Marc Rohlfs (1):
      Enable and configure remote debugging.

# 0.4.0

Marc Rohlfs (6):
      Predefined, overwritable version data.
      Changed default version to latest published version.
      Improved default variables for Tomcat service user, installation and instance. Now, 'tomcat_user_home' and 'tomcat_env_catalina_base' don't need to be defined per Tomcat instance, because the default definitions implicitly set different values.
      Default variable 'tomcat_service_name' is now configured with the value of the variable 'tomcat_user_name', so that it doesn't need to be defined per Tomcat instance.
      Allow optional configuration of a base value for all the port that have to be defined for a Tomcat instance.
      Warning and qualified informaiton on port configurations.

# 0.3.0

Marc Rohlfs (12):
      Improved patterns for files to be ignored by Git
      Applied variable names for service user to new style guide.
      New variables for ansible-tomcat role: - 'tomcat\_env\_catalina\_base' points to the tomcat instance directory. - 'tomcat\_env\_catalina\_home' points to the tomcat installation directory.
      Properly distinguish installtion and instance files.
      Fixed wrong usage of vars 'tomcat\_env\_catalina\_home' and 'tomcat\_env\_catalina\_base'.
      Fixed task definition style: orgsanised meta data before module.
      Added documentation for variable 'tomcat_catalina_base_conf_files'.
      Always copy all conf files from the Tomcat installation to the Tomcat instance without enabling the user to define which files to be copied.
      Allow configuration of ports for Tomcat service.
      Parameterise service, notifications and handlers with service name to enable multiple role invocations within one playbook.
      Moved default definition of 'tomcat_env_catalina_base' to the 'tomcat instance' section.
      Documentation how to invoke the role to install, configure and run multiple Tomcat instances within one playbook.

Mark Kusch (1):
      Update ubuntu-upstart-sshkey container to version 1.0.0

# 0.2.0

Mark Kusch (3):
      Update variables documentation
      Update to current mechanics for ansible roles
      ansible-generator: Add integration test infrastructure

# 0.0.1

* Initial commit


<!-- vim: set nofen ts=4 sw=4 et: -->
