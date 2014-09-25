require 'serverspec'
require 'net/ssh'

include SpecInfra::Helper::DetectOS
include SpecInfra::Helper::Exec
include SpecInfra::Helper::Ssh


if ENV['RAKE_ANSIBLE_USE_VAGRANT']
  require 'lib/vagrant'
  conn = Vagrant.new
else
  require 'lib/docker'
  conn = Docker.new
end


RSpec.configure do |config|
  config.before :all do
    config.host = conn.ssh_host
    opts = Net::SSH::Config.for(config.host)
    opts[:port] = conn.ssh_port
    opts[:keys] = conn.ssh_keys
    opts[:auth_methods] = Net::SSH::Config.default_auth_methods
    config.ssh = Net::SSH.start(conn.ssh_host, conn.ssh_user, opts)
  end
end
