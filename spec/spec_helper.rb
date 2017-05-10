require 'chefspec'
require 'chefspec/berkshelf'

RSpec.configure do |config|
  config.color = true
  config.file_cache_path = '/var/chef/cache'
end

at_exit { ChefSpec::Coverage.report! }
