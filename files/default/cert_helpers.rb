def cert_needs_update(remote, local)
  # Check to make sure that we need to re-pull the file.
  # We re-pull the file if it doesn't exist or if it does
  # but the remote file has changed in size.
  #
  # Note: This will run every time
  if File.exists?(local)
    ruby_block "check_curl_command_output" do
      block do
        Chef::Resource::RubyBlock.send(:include, Chef::Mixin::ShellOut)
        curl_command = "curl -sI '#{remote}' | grep Content-Length | awk '{print $2}'"
        curl_command_out = shell_out(curl_command)
        file_size = curl_command_out.stdout.to_s
        if file_size != File.size(local)
          true
        else
          false
        end
      end
      action :create
    end
  else
    return true
  end
end
