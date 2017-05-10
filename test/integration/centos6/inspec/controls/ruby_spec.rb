ruby_location = attribute(
	'ruby_location',
	default: '/opt/chef/embedded/bin/ruby',
	description: 'Where Ruby is installed on the client'
)
https_url = attribute(
	'https_url',
	default: 'https://www.google.com:443/',
	description: 'The HTTPS url to test against'
)
local_certificate_name = attribute(
	'local_certificate_name',
	default: 'rootCA.pem',
	description: 'The file name of the incoming SSL certificate'
)

url = URI.parse(https_url)

control 'check-ruby-ssl-with-callout' do
	impact 1.0
	title 'Ruby: Call Remote HTTPS Site And Expect 200'
	desc '
	Ensures that the root SSL certificate is installed on the server by making a call
	to a remote website via https
	'
	tag 'ruby','ssl','certificate'
	ruby_ssl_out = command("#{ruby_location} -e \"require 'net/https';req = Net::HTTP.new('#{url.host}', #{url.port});req.use_ssl = true;res = req.request_head('#{url.path}');puts res.code\"")
	describe ruby_ssl_out do
		its('exit_status') { should eq 0 }
		its('stdout') { should match (/200\n/) }
		its('stderr') { should match (//) }
	end
end
# grep -f <(sed '1d;$d' /opt/chef/embedded/ssl/certs/local_certificate.cer) /opt/chef/embedded/ssl/certs/cacert.pem | wc -l
control 'check-ruby-ssl-cert' do
	impact 1.0
	title 'Ruby: Scan Combination Certificate For Our Root Cert'
	desc '
	Ensures that the root SSL certificate is installed on the server by finding it
	in the combination ruby SSL cert
	'
	tag 'ruby','ssl','certificate'
	system_cert = command("#{ruby_location} -e \"require 'net/https';\" -e \"print OpenSSL::X509::DEFAULT_CERT_FILE\"").stdout
	ca_path = command("#{ruby_location} -e \"require 'net/https';\" -e \"print OpenSSL::X509::DEFAULT_CERT_DIR\"").stdout
	orig_cert_len = command("sed '1d;$d' #{ca_path}\/#{local_certificate_name} | wc -l").stdout
	match_len = command("grep -f < <(sed '1d;$d' #{ca_path}/#{local_certificate_name}) #{system_cert} | wc -l")

	describe match_len do
		its('exit_status') { should eq 0 }
		its('stdout') { should eq (orig_cert_len) }
		its('stderr') { should match (//) }
	end
end
