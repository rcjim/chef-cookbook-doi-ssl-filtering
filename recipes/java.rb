#
# Cookbook Name:: doi_ssl_filtering
# Recipe:: java
#
# Attempts to fix SSL certificate issues with Java

require_relative '../libraries/cert_helpers'

encrypted_data_bag_name = node['doi_ssl_filtering']['encrypted_data_bag_name']
begin
  java_store_password = data_bag_item(encrypted_data_bag_name, 'java')['keystore_password']
rescue
  java_store_password = 'changeit'
  Chef::Log.info('A java data bag does not exist. Will attempt to use Java store password \'changeit\'')
end

node['doi_ssl_filtering']['cert_locations'].each do |loc|
  filename = get_cert_filemame(loc)
  original_file = File.join(Chef::Config[:file_cache_path], filename)

  execute 'add cert to java keystore' do
    command "/usr/bin/keytool -keystore $JAVA_HOME/jre/lib/security/cacerts -importcert -alias #{filename} -file #{original_file} -storepass #{java_store_password} -noprompt"
    not_if "keytool -list -keystore $JAVA_HOME/jre/lib/security/cacerts -v -storepass changeit | grep -q $(/usr/bin/openssl x509 -noout -in #{original_file} -fingerprint -md5 | cut -d '=' -f 2)"
  end
end
