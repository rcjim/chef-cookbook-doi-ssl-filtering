require 'spec_helper.rb'

describe command('/usr/bin/keytool -list -keystore $JAVA_HOME/jre/lib/security/cacerts -alias doi.ssl.intercept -storepass changeit') do
  its(:exit_status) { should eq 0 }
end
