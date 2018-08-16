require 'spec_helper.rb'

cert_file = '/tmp/kitchen/cache/rootCA.pem'
if os[:family] == 'windows'
  cert_file = 'C:/Users/vagrant/AppData/Local/Temp/kitchen/cache/rootCA.pem'
end

describe file(cert_file) do
  it { should exist }
  it { should be_file }
end
