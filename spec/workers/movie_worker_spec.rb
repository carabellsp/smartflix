require 'rails_helper'
require 'sidekiq/testing'

RSpec.describe MovieWorker, :vcr do
  subject { described_class.perform_async }

  Sidekiq::Testing.inline!

  let(:title) { 'Shrek' }

  it 'adds a movie', :vcr, :aggregate_failures do
    expect { subject }.to change(Movie, :count).by 1

    # expect(Movie.last.title).to eq(title)
  end
end
