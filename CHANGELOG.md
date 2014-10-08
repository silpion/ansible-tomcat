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
