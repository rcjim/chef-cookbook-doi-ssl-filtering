require 'spec_helper.rb'

describe file('/tmp/kitchen/cache/doi.cer') do
  it { should exist }
  it { should be_file }
end
