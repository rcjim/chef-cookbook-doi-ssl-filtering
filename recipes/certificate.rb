#
# Cookbook Name:: doi_ssl_filtering
# Recipe:: certificate
#
# Description: Gets the DOI root ceritificate

require 'uri'
require_relative '../libraries/cert_helpers'

node.run_state[:doi_ssl_cert_location] = if node['platform'] == 'windows'
                                           node.run_state[:doi_ssl_cert_location].tr('\\', '/')
                                         else
                                           "#{Chef::Config[:file_cache_path]}/doi.cer"
                                         end

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
    if node['platform'] != 'windows'
      execute 'Get remote DOI cert via curl' do
        command "curl -k -o #{node.run_state[:doi_ssl_cert_location]} '#{path}'"
        not_if { ::File.exist?(node.run_state[:doi_ssl_cert_location]) }
      end
    else
      powershell_script 'Get remote DOI cert via powershell' do
        code "[System.Net.ServicePointManager]::ServerCertificateValidationCallback = {$true}; (New-Object System.Net.WebClient).DownloadFile('#{path}', '#{node.run_state[:doi_ssl_cert_location]}')"
        not_if { ::File.exist?(node.run_state[:doi_ssl_cert_location]) }
      end
    end
  elsif scheme == 'file'
    remote_file 'Get local DOI cert' do
      source path
      not_if { ::File.exist?(node.run_state[:doi_ssl_cert_location]) }
    end
  else
    Chef::Application.fatal!('Could not properly parse the path in "doi_ssl_filtering.cert_location". Must start with "http://", "https://" or "file://"', 1)
  end
end
