require 'uri'

def get_cert_filemame(location)
  # Gets the certificate's filename from the URI location
  uri = URI.parse(location)
  scheme = uri.scheme
  if %w[http https].include?(scheme)
    uri.path.split('/').last
  elsif scheme == 'file'
    File.basename(location)
  else
    raise 'Location is neither http, https or file'
  end
end

# Check to make sure that we need to re-pull the file.
# We re-pull the file if it doesn't exist or if it does
# but the remote file has changed in size.
#
# Note: This will run every time
def cert_needs_update(remote, local)
  return true unless File.exist?(local)

  ruby_block 'check_curl_command_output' do
    block do
      Chef::Resource::RubyBlock.send(:include, Chef::Mixin::ShellOut)
      curl_command = "curl -sI '#{remote}' | grep Content-Length | awk '{print $2}'"
      shell_out(curl_command).stdout.to_s != File.size(local)
    end
    action :run
  end
end
