# http://serverspec.org/resource_types.html
# http://serverspec.org/advanced_tips.html

# testing operating system specific
#
# either:
#
# if os[:family] == 'redhat'
# if os[:release] == 7
# if os[:arch] == 'x86_64'
#
#   nested:
# if os[:family] == 'redhat'
#   if os[:release] == 7
#     describe resource(...) do
#     end
#   else
#     describe resource(...) do
#     end
#   end
#
# or:
#
# describe file('...'), :if => os[:family] == 'archlinux' do ... end
#
# or multiple OS share the same test data
#
# describe file('...'), :if => ['archlinux', 'redhat'].include?(os[:family]) do ... end

require 'spec_helper'

describe 'Testing ansible-tomcat local facts' do
  describe file('/etc/ansible/facts.d/tomcat.fact') do
    it { should be_file }
    it { should be_mode '644' }
    it { should be_owned_by 'root' }
    it { should be_grouped_into 'root' }
    its(:content) { should match /"vendor": "Silpion"/ }
    its(:content) { should match /"vendor_url": "http:\/\/silpion.de"/ }
    its(:content) { should match /"vendor_github": "https:\/\/github.com\/silpion"/ }
    its(:content) { should match /"role_version": "2.2.0"/ }
  end
end
