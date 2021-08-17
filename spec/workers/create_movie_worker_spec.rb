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

  # it 'sets the correct attributes' do
  #   expect(Movie.last).to have_attributes(
  #     title: 'Black Panther',
  #     year: 2018,
  #     released: 'Fri, 16 Feb 2018'.to_date,
  #     genre: 'Action, Adventure, Sci-Fi',
  #     director: 'Ryan Coogler',
  #     plot: "T'Challa, heir to the hidden but advanced kingdom of Wakanda, must step forward to                                    lead his people into a new future and must confront a challenger from his country's                                    past.",
  #     language: 'English, Swahili, Nama, Xhosa, Korean',
  #     runtime: 134
  #   )
  # end
end
