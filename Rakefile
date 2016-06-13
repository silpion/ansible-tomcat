require 'rake'
require 'rspec/core/rake_task'


# the Docker and Vagrant specific rake tasks live in the rake/
#   directory.
# Add the rake/ directory to the ruby $LOAD_PATH.
$:.unshift File.dirname(__FILE__) + '/rake'
require 'vagrant'


desc "Run integration tests with serverspec"
RSpec::Core::RakeTask.new(:spec) do |t|
  t.pattern = 'spec/*/*_spec.rb'
end


desc "Test ansible playbook syntax"
task :lint do
  sh %{ansible-playbook --inventory-file tests/hosts --syntax-check tests/test.yml}
end
task :default => :lint


desc "Run test suite with Vagrant"
task :suite => [
  :lint,
  :up,
  :provision,
  :spec,
  :clean
]
