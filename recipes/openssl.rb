#
# Cookbook Name:: doi_ssl_filtering
# Recipe:: openssl
#
# Updates OpenSSL to use the DOI certificate

# Attained from
# http://tinyurl.com/lmjwvqj

package 'ca-certificates'

remote_file '/etc/pki/ca-trust/source/anchors/doi.cer' do
  source "file://#{node.run_state[:doi_ssl_cert_location]}"
  # The certificate is public but I don't want the logs to be
  # filled with it
  sensitive true
  notifies :run, "execute[update ca certs]", :immediately
end

execute 'update ca certs' do
  command '/usr/bin/update-ca-trust force-enable && /usr/bin/update-ca-trust extract'
  action :nothing
end
