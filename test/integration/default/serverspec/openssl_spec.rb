require 'spec_helper.rb'

describe package('ca-certificates') do
  it { should be_installed }
end

describe file('/etc/pki/ca-trust/source/anchors/DOIRootCA.crt') do
  it { should exist }
  it { should be_file }
end
