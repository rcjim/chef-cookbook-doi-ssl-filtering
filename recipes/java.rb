#
# Cookbook Name:: doi_ssl_filtering
# Recipe:: java
#
# Attempts to fix SSL certificate issues with Java

encrypted_data_bag_name = node['doi_ssl_filtering']['encrypted_data_bag_name']
cert_alias = 'doi.ssl.intercept'
java_store_password = 'changeit'

begin
  java_store_password = data_bag_item(encrypted_data_bag_name, 'java')['keystore_password']
rescue
  Chef::Log.info('A java data bag does not exist. Will attempt to use Java store password \'changeit\'')
end

execute "add cert to java keystore" do
  command "/usr/bin/keytool -keystore $JAVA_HOME/jre/lib/security/cacerts -importcert -alias #{cert_alias} -file #{node.run_state[:doi_ssl_cert_location]} -storepass #{java_store_password} -noprompt"
  not_if "/usr/bin/keytool -list -keystore $JAVA_HOME/jre/lib/security/cacerts -alias #{cert_alias} -storepass #{java_store_password}"
end
