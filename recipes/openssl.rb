#
# Cookbook Name:: doi_ssl_filtering
# Recipe:: openssl
#
# Updates OpenSSL to use the DOI certificate

# Attained from
# http://tinyurl.com/lmjwvqj

require_relative '../libraries/cert_helpers'

package 'ca-certificates'

node['doi_ssl_filtering']['cert_locations'].each do |loc|
  filename = get_cert_filemame(loc)
  local_file_path = File.join(Chef::Config[:file_cache_path], filename)

  remote_file "/etc/pki/ca-trust/source/anchors/#{filename}" do
    source "file://#{local_file_path}"
    # The certificate is public but I don't want the logs to be
    # filled with it
    sensitive true
    notifies :run, 'execute[update ca certs]', :immediately
  end
end

execute 'update ca certs' do
  command '/usr/bin/update-ca-trust force-enable && /usr/bin/update-ca-trust extract'
  action :nothing
end
