# frozen_string_literal: true

require 'rails_helper'
require 'sidekiq/testing'

RSpec.describe CreateMovieWorker, :vcr do
  subject { described_class.new }

  let(:movie) { 'Black Panther' }

  Sidekiq::Testing.inline!

  it 'adds a movie', :vcr, :aggregate_failures do
    expect { subject.perform(movie) }.to change(Movie, :count).by(1)
  end

  it 'calls CreateMovie::EntryPoint' do
    expect(CreateMovie::EntryPoint).to receive(:new)

    subject.perform(movie)
  end
end
