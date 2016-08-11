#
# Cookbook Name:: doi_ssl_filtering
# Recipe:: certificate
#
# Description: Gets the DOI root ceritificate

require 'uri'
require_relative '../files/default/cert_helpers'

node.run_state[:doi_ssl_cert_location] = "#{Chef::Config[:file_cache_path]}/doi.cer"
path = node['doi_ssl_filtering']['cert_location']
retrieve_cert = cert_needs_update(path, node.run_state[:doi_ssl_cert_location])

if path.to_s == ''
  Chef::Application.fatal!('"doi_ssl_filtering.cert_location" attribute is required', 1)
end

scheme = URI.parse(path).scheme
if retrieve_cert == true
  if scheme == 'http' || scheme == 'https'
    # Attempt to grab the DOI cert remotely. If HTTPS,
    # this will probably require bypassing SSL verification
    # since we may be on the DOI network
    execute 'Get remote DOI cert' do
      command "curl -k -o #{node.run_state[:doi_ssl_cert_location]} '#{path}'"
      not_if do ::File.exists?(node.run_state[:doi_ssl_cert_location]) end
    end
  elsif scheme == 'file'
    remote_file 'Get local DOI cert' do
      source path
      not_if do ::File.exists?(node.run_state[:doi_ssl_cert_location]) end
    end
  else
    Chef::Application.fatal!('Could not properly parse the path in "doi_ssl_filtering.cert_location". Must start with "http://", "https://" or "file://"', 1)
  end
end
