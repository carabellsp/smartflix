# frozen_string_literal: true

require 'vcr'

VCR.configure do |config|
  config.cassette_library_dir = 'spec/vcr_cassettes' # the directory where VCR will store its cassettes (HTTP interactions)
  config.configure_rspec_metadata!
  config.hook_into :webmock # connects vcr w webmock to stub requests
  config.ignore_localhost = true # ensures VCR ignores requests to localhost
end
