require 'rake'
require 'rspec/core/rake_task'


desc "Run integration tests with serverspec"
RSpec::Core::RakeTask.new(:spec) do |t|
  t.pattern = 'spec/*/*_spec.rb'
end


desc "Test ansible playbook syntax"
task :lint do
  sh %{ansible-playbook --inventory-file tests/hosts --syntax-check tests/test.yml}
end
task :default => :lint


desc "vagrant up --no-provision"
task :up do
  if ENV['ANSIBLE_TOMCAT_VAGRANT_PROVIDER']
    sh 'vagrant', 'up', '--no-provision', '--provider', ENV['ANSIBLE_TOMCAT_VAGRANT_PROVIDER']
  else
    sh %{vagrant up --no-provision}
  end
end

desc "vagrant halt; vagrant destroy --force"
task :clean do
  if ENV['RAKE_ANSIBLE_VAGRANT_DONT_CLEANUP'] != '1'
    sh %{vagrant halt}
    sh %{vagrant destroy --force}
  end
end

desc "vagrant provision"
task :provision => :up do
  sh %{vagrant provision}
end

desc "Run test suite with Vagrant"
task :suite => [
  :lint,
  :up,
  :provision,
  :spec,
  :clean
]
