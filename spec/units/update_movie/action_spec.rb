# frozen_string_literal: true

require 'rails_helper'
require_relative 'update_movie_shared_examples'

RSpec.describe UpdateMovie::Action do
  subject { described_class.new.call(response, movie) }

  let(:response) { instance_double(HTTParty::Response, body: response_body) }

  before do
    allow(response).to receive(:parsed_response).and_return(response_body)
  end

  context 'when the response has updated data' do
    let(:response_body) do
      { 'Title' => 'The Notebook',
        'Year' => 2005,
        'Genre' => 'Adventure' }
    end

    let(:movie) { create(:movie, title: 'The Notebook', genre: 'Drama', year: 2004) }

    # it 'updates the movie object' do
    #   expect { subject }.to change(movie, :updated_at)
    # end
    include_examples 'successfully updates movie object'

    it 'updates the movie object with the new attributes from the response' do
      subject
      expect(movie.reload).to have_attributes(title: 'The Notebook', year: 2005, genre: 'Adventure')
    end
  end

  context 'when the response has no updated data' do
    let(:response_body) do
      { 'Title' => 'The Notebook', 'Year' => 2004, 'Genre' => 'Drama' }
    end

    let(:movie) { create(:movie, title: 'The Notebook', genre: 'Drama') }

    it ' does not update the movie object' do
      expect { subject }.not_to change(movie, :updated_at)
    end

    it 'does not change the movie attributes' do
      subject
      expect(movie.reload).to have_attributes(title: 'The Notebook', genre: 'Drama')
    end
  end
end
