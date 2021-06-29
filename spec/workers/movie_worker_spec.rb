# frozen_string_literal: true

require 'rails_helper'
require 'sidekiq/testing'

RSpec.describe MovieWorker, :vcr do
  subject { described_class.perform_async }

  Sidekiq::Testing.inline!

  it 'adds a movie', :vcr, :aggregate_failures do
    expect { subject }.to change(Movie, :count).by 1
  end

  # describe '#perform', :vcr do
  #   let(:movie) { Movie.new }
  #   let(:title) { 'Scarface' }
  #   subject { described_class.perform }
  #
  #   it 'should return the correct movie' do
  #     expect(movie.title).to eq('Scarface')
  #   end
  # end
end
