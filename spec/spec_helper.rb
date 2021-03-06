require "rspec"
require "webmock/rspec"
require "vcr"
require "icheckmovies"

RSpec.configure do |config|
  config.mock_with :rspec
  config.extend VCR::RSpec::Macros
end

VCR.config do |c|
  c.cassette_library_dir = "spec/fixtures/vcr_cassettes"
  c.stub_with :webmock
  c.default_cassette_options = {
    record: :new_episodes
  }
  c.allow_http_connections_when_no_cassette = false
end