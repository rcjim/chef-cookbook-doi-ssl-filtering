require 'spec_helper.rb'

cert_file = '/tmp/kitchen/cache/DOIRootCA.crt'
if os[:family] == 'windows'
  cert_file = 'C:/Users/vagrant/AppData/Local/Temp/kitchen/cache/DOIRootCA.crt'
end

describe file(cert_file) do
  it { should exist }
  it { should be_file }
end
