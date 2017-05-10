require 'spec_helper'

describe 'doi_ssl_filtering::ruby CentOS 6.8' do
  let(:chef_run) { ChefSpec::SoloRunner.new(platform: 'centos', version: '6.8').converge('doi_ssl_filtering::ruby') }

	ruby_block_name = 'Append /opt/chefdk/embedded/ssl/certs/root.cer to /usr/local/etc/openssl/cert.pem'

	it 'Creates a remote_file for /opt/chefdk/embedded/ssl/certs/root.cer' do
    expect(chef_run).to create_remote_file('/opt/chefdk/embedded/ssl/certs/root.cer')
			.with(source: 'file:///var/chef/cache/root.cer')

		download = chef_run.remote_file('/opt/chefdk/embedded/ssl/certs/root.cer')
		expect(download).to notify("ruby_block[#{ruby_block_name}]")
			.to(:create)
				.immediately
  end

	it 'Creates a ruby_block to append SSL cert' do
    expect(chef_run).to_not run_ruby_block("#{ruby_block_name}")
  end
end
