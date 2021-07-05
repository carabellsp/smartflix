# frozen_string_literal: true

require 'vcr'

VCR.configure do |config|
  config.cassette_library_dir = 'spec/vcr_cassettes'
  config.configure_rspec_metadata!
  config.hook_into :webmock
  config.ignore_localhost = true
end
