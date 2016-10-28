#
# Cookbook Name:: doi_ssl_filtering
# Recipe:: windows
#
# Adds the DOI certificate to the windows certificate store

windows_certificate node.run_state[:doi_ssl_cert_location] do
  store_name 'ROOT'
  action :create
end
