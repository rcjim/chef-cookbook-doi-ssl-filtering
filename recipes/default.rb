#
# Cookbook Name:: doi_ssl_filtering
# Recipe:: default
#

include_recipe 'doi_ssl_filtering::certificate'

if node['platform'] != 'windows'
  include_recipe 'doi_ssl_filtering::openssl'
else
  include_recipe 'doi_ssl_filtering::windows'
end
