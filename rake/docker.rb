require 'rake'
require 'rspec/core/rake_task'

require './spec/lib/docker'
d = Docker.new


desc "Bring up Docker container"
task :up do
  d.docker_pull
  d.docker_run
  d.ssh_available?
end


desc "Provision Docker container"
task :provision => [:up] do
  d.ansible_hosts_add
  sh %{ansible-playbook --inventory-file #{d.ansible_hosts_file} --limit #{d.env_name} tests/playbook.yml}
  d.ansible_hosts_del
end


desc "Cleanup Docker container environment"
task :clean do
  d.docker_stop
  d.docker_rm
  d.ansible_hosts_del
end


desc "SSH into the Docker container"
task :ssh do
  sh %{ssh -l #{d.ssh_user} -i #{d.ssh_keys} -p #{d.ssh_port} #{d.ssh_host}}
end
