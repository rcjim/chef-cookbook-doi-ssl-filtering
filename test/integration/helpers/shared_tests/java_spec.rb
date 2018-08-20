require 'spec_helper.rb'

# Assuming that the cert sits in the Chef cache location, fingerprint it and verify against
# the fingerprints in the keystore to check for a match
describe command("keytool -list -keystore $JAVA_HOME/jre/lib/security/cacerts -storepass changeit -v | grep -q $(/usr/bin/openssl x509 -noout -in /tmp/kitchen/cache/rootCA.pem -fingerprint -sha256 | cut -d '=' -f 2)") do
  its(:exit_status) { should eq 0 }
end
