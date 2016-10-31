require 'spec_helper.rb'

# Assuming that the DOI cert sits in the Chef cache location, fingerprint it and verify against
# the fingerprints in the keystore to check for a match
describe command("keytool -list -keystore $JAVA_HOME/jre/lib/security/cacerts -storepass changeit | grep -q $(/usr/bin/openssl x509 -noout -in /tmp/kitchen/cache/DOIRootCA.crt -fingerprint -md5 | cut -d '=' -f 2)") do
  its(:exit_status) { should eq 0 }
end
