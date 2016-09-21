require 'spec_helper.rb'

#  A webpage indicated that powershell is used
describe command('Get-ChildItem -Path cert:LocalMachine\\Root -Recurse') do
  its(:stdout) { should match /CN=DOIRootCA2/ }
end
