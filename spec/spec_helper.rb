require 'bundler/setup'
Bundler.setup

require 'prettyp'

require 'pry'

require 'fakefs/safe'
require 'fakefs/spec_helpers'

RSpec.configure do |config|
#  include FakeFS::SpecHelpers
end
