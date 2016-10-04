require 'serverspec'
require 'lib/vagrant'

c = Vagrant.new

set :backend, :ssh
set :host, c.ssh_host
set :ssh_options, :user => c.ssh_user, :port => c.ssh_port, :keys => c.ssh_keys

set :env, :LANG => 'C', :LC_MESSAGES => 'C'
set :path, '/usr/local/sbin:/usr/sbin:/sbin:$PATH'
