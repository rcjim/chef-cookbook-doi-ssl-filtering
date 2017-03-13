#
# Cookbook Name:: doi_ssl_filtering
# Recipe:: certificate
#
# Description: Gets the DOI root ceritificates

require_relative '../libraries/cert_helpers'

node['doi_ssl_filtering']['cert_locations'].each do |loc|
  filename = get_cert_filemame(loc)
  local_file_path = File.join(Chef::Config[:file_cache_path], filename)

  remote_file local_file_path do
    source loc
    # The certificate is public but I don't want the logs to be
    # filled with it
    sensitive true
    use_last_modified true
    use_etag true
    use_conditional_get true
    action :create_if_missing
  end
end
