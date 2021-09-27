# frozen_string_literal: true

RSpec.shared_examples 'successfully logs timestamped warning' do
  it 'logs a Rails warning with timestamp' do
    travel_to Time.zone.local(2021)
    expect(Rails.logger).to receive(:warn).with('The request at 2021-01-01 00:00:00 UTC has returned an error in the response')
    subject
  end
end

