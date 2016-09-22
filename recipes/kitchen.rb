#
# Cookbook Name:: doi_ssl_filtering
# Recipe:: kitchen
#
# Updates the DOI certificate for guest VMs created
# and tested via Chef's Test Kitchen utility

topdir = '/opt'
if node['platform'] == "windows"
  topdir = 'c:/opscode'
end
remote_file "#{topdir}/chef/embedded/ssl/doi_cert.pem" do
  source "file://#{node.run_state[:doi_ssl_cert_location]}"
  # The certificate is public but I don't want the logs to be
  # filled with it
  sensitive true
  notifies :run, "ruby_block[reload_client_config]", :immediately
end

# The file also needs to be appended to /opt/chef/embedded/ssl/certs/cacert.pem
ruby_block 'reload_client_config' do
  block do
    to_append = File.read(node.run_state[:doi_ssl_cert_location])
    File.open("#{topdir}/chef/embedded/ssl/certs/cacert.pem", "a") do |handle|
      handle.puts "\n\nDOI ROOT CERT\n=============\n#{to_append}"
    end
  end
  action :nothing
end
