require 'spec_helper.rb'

describe file('/opt/chef/embedded/ssl/doi_cert.pem') do
  it { should exist }
  it { should be_file }
end

describe file('/opt/chef/embedded/ssl/certs/cacert.pem') do
  it { should exist }
  it { should be_file }
  it { should contain 'DOI ROOT CERT' }
end
