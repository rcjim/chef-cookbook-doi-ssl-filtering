#
# Cookbook Name:: doi_ssl_filtering
# Recipe:: windows
#
# Adds the DOI certificate to the windows certificate store

node['doi_ssl_filtering']['cert_locations'].each do |loc|
  filename = get_cert_filemame(loc)
  original_file = File.join(Chef::Config[:file_cache_path], filename)

  windows_certificate original_file do
    store_name 'ROOT'
    action :create
  end
end
