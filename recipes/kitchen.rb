#
# Cookbook Name:: doi_ssl_filtering
# Recipe:: kitchen
#
# Updates the DOI certificate for guest VMs created
# and tested via Chef's Test Kitchen utility

require_relative '../libraries/cert_helpers'

topdir = if node['platform'] == 'windows'
           'c:/opscode'
         else
           '/opt'
         end

cacert_file = File.join(topdir, 'chef', 'embedded', 'ssl', 'certs', 'cacert.pem')

node['doi_ssl_filtering']['cert_locations'].each do |loc|
  filename = get_cert_filemame(loc)
  original_file = File.join(Chef::Config[:file_cache_path], filename)
  local_ssl_file = File.join(topdir, 'chef', 'embedded', 'ssl', filename)

  remote_file 'Create Chef SSL Cert' do
    path local_ssl_file
    source "file://#{original_file}"
    # The certificate is public but I don't want the logs to be
    # filled with it
    sensitive true
  end

  # The file also needs to be appended to /opt/chef/embedded/ssl/certs/cacert.pem
  ruby_block 'Reload client config' do
    block do
      to_append = File.read(original_file)
      File.open(cacert_file, 'a') do |handle|
        handle.puts "\n\nROOT CERT\n=============\n#{to_append}"
      end
    end
    action :nothing
    subscribes :create, 'remote_file[Create Chef SSL Cert]', :immediately
  end
end
