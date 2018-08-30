require 'digest'
require 'openssl'
require 'uri'

ruby_location = attribute(
	'ruby_location',
	default: '/opt/chef/embedded/bin/ruby',
	description: 'Where Ruby is installed on the client'
)

cert_locations = attribute('cert_locations',
                           default: ['file:///tmp/kitchen/data/rootCA.pem'],
                           description: 'List of certificates that should have been installed'
                           )

keystore_password = attribute(
	'keystore_password',
	default: 'changeit',
	description: 'The password used to protect the keystore'
)


control 'check-java-cacerts' do
  impact 1.0
  title 'Java: Certificate in keystore'
  desc 'Ensures that the root certificate is in the Java keystore'
  tag 'java','certificate'

  cert_locations.each do |loc|
    uri = URI.parse(loc)
    get_cert = if uri.scheme == 'file'
                 command("#{ruby_location} -e \"print File.read('#{uri.path}')\"")
               else
                 command("#{ruby_location} -e \"require 'net/https'; uri = URI.parse('#{loc}'); req = Net::HTTP.new(\'#{uri.host}\', #{uri.port}); req.use_ssl = true if uri.scheme == 'https'; print req.request(Net::HTTP::Get.new('#{loc}')).body\"")
               end
    describe get_cert do
      its('stderr') { should match (//) }
      its('exit_status') { should eq 0 }
      its('stdout') { should match (/BEGIN\s+CERTIFICATE/) }
    end

    cert = OpenSSL::X509::Certificate.new(get_cert.stdout)

    # TODO: Get SHA256 fingerprint in Windows
    if os.family == 'windows'
      fingerprint = OpenSSL::Digest::SHA1.new(cert.to_der).to_s.upcase
      list = powershell('get-childitem -Path cert:\LocalMachine\Root | Select Thumbprint')
      describe list do
        its('stderr') { should match (//) }
        its('exit_status') { should eq 0 }
        its('stdout') { should include fingerprint }
      end
    else
      fingerprint = OpenSSL::Digest::SHA256.new(cert.to_der).to_s.scan(/../).map { |s| s.upcase }.join(':')
      list = bash("if [ -f $JAVA_HOME/lib/security/cacerts ]; then $JAVA_HOME/bin/keytool -list -keystore $JAVA_HOME/lib/security/cacerts -storepass #{keystore_password} -v; else $JAVA_HOME/bin/keytool -list -keystore $JAVA_HOME/jre/lib/security/cacerts -storepass #{keystore_password} -v; fi | grep SHA256:")
      describe list do
        its('stderr') { should match (//) }
        its('exit_status') { should eq 0 }
        its('stdout') { should match (/^\s+SHA256:\s/) }
        its('stdout') { should include fingerprint }
      end
    end
  end
end
