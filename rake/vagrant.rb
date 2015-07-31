require 'rake'
require 'rspec/core/rake_task'


desc "Bring up Vagrant VM"
task :up do
  if ENV['ANSIBLE_TOMCAT_VAGRANT_PROVIDER']
    sh 'vagrant', 'up', '--no-provision', '--provider', ENV['ANSIBLE_TOMCAT_VAGRANT_PROVIDER']
  else
    sh %{vagrant up --no-provision}
  end
end


desc "Provision Vagrant VM"
task :provision => [:up] do
  sh %{vagrant provision}
end


desc "Cleanup Vagrant VM environment"
task :clean do
  if not ENV['RAKE_ANSIBLE_VAGRANT_DONT_CLEANUP'] == '1'
    sh %{vagrant halt}
    sh %{vagrant destroy --force}
  end
end


desc "SSH into the Vagrant VM"
task :ssh do
  sh %{vagrant ssh}
end
