ruby_location = '/opt/chef/embedded/bin/ruby'
url = URI.parse("https://www.google.com:443/")
control 'check-kitchen-ssl' do
	impact 0.3
	title 'Ruby: Install SSL certificates'
	desc '
	This test is only here while the kitchen recipe exists. That recipe is
	deprecated. This test should be removed once the kitchen recipe is removed.
	'
	tag 'ruby','ssl','certificate'
	ruby_ssl_out = command("#{ruby_location} -e \"require 'net/https';req = Net::HTTP.new('#{url.host}', #{url.port});req.use_ssl = true;res = req.request_head('#{url.path}');puts res.code\"")
	describe ruby_ssl_out do
		its('exit_status') { should eq 0 }
		its('stdout') { should match (/200\n/) }
		its('stderr') { should match (//) }
	end
end
