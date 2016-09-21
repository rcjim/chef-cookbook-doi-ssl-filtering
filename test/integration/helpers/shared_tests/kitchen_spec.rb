require 'spec_helper.rb'

topdir = '/opt'
if os[:family] == 'windows'
  topdir = 'c:/opscode'
end

describe file("#{topdir}/chef/embedded/ssl/doi_cert.pem") do
  it { should exist }
  it { should be_file }
end

describe file("#{topdir}/chef/embedded/ssl/certs/cacert.pem") do
  it { should exist }
  it { should be_file }
  it { should contain 'DOI ROOT CERT' }
end
