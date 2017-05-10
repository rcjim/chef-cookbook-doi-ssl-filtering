#
# Cookbook Name:: doi_ssl_filtering
# Recipe:: ruby
#
# Updates the SSL root certificate for Ruby

require_relative '../libraries/cert_helpers'
require 'net/https'

# Thanks to https://github.com/mislav/ssl-tools/blob/8b3dec4/doctor.rb#L26-L27
ca_path = (ENV[OpenSSL::X509::DEFAULT_CERT_DIR_ENV] || OpenSSL::X509::DEFAULT_CERT_DIR).chomp('/')
cacert_file = ENV[OpenSSL::X509::DEFAULT_CERT_FILE_ENV] || OpenSSL::X509::DEFAULT_CERT_FILE

node['doi_ssl_filtering']['cert_locations'].each do |loc|
  filename = get_cert_filemame(loc)
  original_file = File.join(Chef::Config[:file_cache_path], filename)
  local_ssl_file = File.join(ca_path, filename)

  remote_file local_ssl_file do
    source "file://#{original_file}"
    # The certificate is public but I don't want the logs to be filled with it
    sensitive true
    notifies :create, "ruby_block[Append #{local_ssl_file} to #{cacert_file}]", :immediately
  end

  # The file also needs to be appended to cacert_file
  ruby_block "Append #{local_ssl_file} to #{cacert_file}" do
    block do
      to_append = File.read(original_file)
      File.open(cacert_file, 'a') do |handle|
        handle.puts "\n\nROOT CERT\n=============\n#{to_append}"
      end
    end
    action :nothing
  end
end
