#
# Cookbook Name:: doi-ssl-filtering
# Resource:: java_keytool_management
# Description:: Resource for importing certificates

resource_name :java_keytool_management

default_action :import

property :cert_alias, String, required: true
property :certificate, String, required: true
property :keystore, String, required: false
property :storepass, String, required: false

action :import do
  keytool_args = ['-keystore', java_cacerts_location(new_resource.keystore),
                  '-noprompt']
  import_args = ['-importcert',
                 '-alias', new_resource.cert_alias,
                 '-file', new_resource.certificate]
  list_args = ['-list']
  keytool_args.push('-storepass', new_resource.storepass) unless new_resource.storepass.nil?

  execute "Add cert @#{new_resource.name} to java keystore" do
    command "#{keytool_location} #{import_args.join(' ')} #{keytool_args.join(' ')}"
    not_if "#{keytool_location} #{list_args.join(' ')} #{keytool_args.join(' ')} "\
           "| grep -q $(/usr/bin/openssl x509 -noout -in #{new_resource.certificate} -fingerprint -#{fingerprint_digest} | cut -d '=' -f 2)"
    sensitive true unless new_resource.storepass.nil?
    action :run
  end
end

# Get the location of the keytool binary
# @return The pathname to keytool
def keytool_location
  if ::File.exist?("#{node['java']['java_home']}/jre/bin/keytool")
    "#{node['java']['java_home']}/jre/bin/keytool"
  elsif ::File.exist?("#{node['java']['java_home']}/bin/keytool")
    "#{node['java']['java_home']}/bin/keytool"
  else
    '/usr/bin/keytool'
  end
end

# Determine where cacerts is located. Java 10 has it in a new location
# @param keystore [String] Location of cacerts
# @return cacert location
def java_cacerts_location(keystore)
  if !keystore.nil? && !keystore.empty?
    keystore
  elsif ::File.exist?("#{node['java']['java_home']}/jre/lib/security/cacerts")
    "#{node['java']['java_home']}/jre/lib/security/cacerts"
  else
    "#{node['java']['java_home']}/lib/security/cacerts"
  end
end

# Set fingerprint digest to use with openssl
# @return the digest that keytool used when listing certs
def fingerprint_digest
  if node['java']['jdk_version'].to_i < 9
    'sha1'
  else
    'sha256'
  end
end
