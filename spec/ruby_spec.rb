require 'spec_helper'
require 'net/https'

ca_path = (ENV[OpenSSL::X509::DEFAULT_CERT_DIR_ENV] || OpenSSL::X509::DEFAULT_CERT_DIR).chomp('/')
cacert_file = ENV[OpenSSL::X509::DEFAULT_CERT_FILE_ENV] || OpenSSL::X509::DEFAULT_CERT_FILE

describe 'doi_ssl_filtering::ruby CentOS 6.8' do
  let(:chef_run) { ChefSpec::SoloRunner.new(platform: 'centos', version: '6.8').converge('doi_ssl_filtering::ruby') }

	ruby_block_name = "Append #{ca_path}/root.cer to #{cacert_file}"

	it 'Creates a remote_file' do
    expect(chef_run).to create_remote_file("#{ca_path}/root.cer")
			.with(source: 'file:///var/chef/cache/root.cer')

		download = chef_run.remote_file("#{ca_path}/root.cer")
		expect(download).to notify("ruby_block[#{ruby_block_name}]")
			.to(:create)
				.immediately
  end

	it 'Creates a ruby_block to append SSL cert' do
    expect(chef_run).to_not run_ruby_block("#{ruby_block_name}")
  end
end
