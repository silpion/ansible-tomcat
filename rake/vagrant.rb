require 'rake'
require 'rspec/core/rake_task'


desc "Bring up Vagrant VM"
task :up do
  sh %{vagrant up --no-provision}
end


desc "Provision Vagrant VM"
task :provision => [:up] do
  sh %{vagrant provision}
end


desc "Cleanup Vagrant VM environment"
task :clean do
  sh %{vagrant halt}
  sh %{vagrant destroy --force}
end


desc "SSH into the Vagrant VM"
task :ssh do
  sh %{vagrant ssh}
end
