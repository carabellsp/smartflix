VCR.configure do |config|
  config.cassette_library_dir = "spec/vcr_cassettes"
  config.configure_rspec_metadata!
  config.hook_into :webmock
end

RSpec.describe MovieWorker, :vcr do
  it 'hello'
end
