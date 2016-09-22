require 'spec_helper.rb'

cert_file = '/tmp/kitchen/cache/doi.cer'
if os[:family] == 'windows'
  cert_file = 'C:/Users/vagrant/AppData/Local/Temp/kitchen/cache/doi.cer'
end

describe file(cert_file) do
  it { should exist }
  it { should be_file }
end
