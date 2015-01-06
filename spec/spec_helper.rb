require 'serverspec'


if ENV['RAKE_ANSIBLE_USE_VAGRANT']
  require 'lib/vagrant'
  c = Vagrant.new
else
  require 'lib/docker'
  c = Docker.new
end


set :backend, :ssh
set :host, c.ssh_host
set :ssh_options, :user => c.ssh_user, :port => c.ssh_port, :keys => c.ssh_keys
