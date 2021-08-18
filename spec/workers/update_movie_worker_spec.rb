# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UpdateMovieWorker do
  context 'when testing update movie worker' do
    subject { described_class.new }

    let!(:movie) { create(:movie, title: 'The Notebook') }
    let(:dummy_omdb_adapter) { instance_double(Omdb::ApiAdapter) }
    let(:response) { instance_double(HTTParty::Response, body: response_body) }
    let(:response_body) do
      { 'Title' => 'The Notebook',
        'Year' => 2004,
        'Released' => 'Fri, 25 Jun 2004',
        'Genre' => 'Drama, Romance',
        'Director' => 'Nick Cassavetes',
        'Plot' => 'A poor yet passionate young man falls in love with a rich young woman, giving her a        sense of freedom, but they are soon separated because of their social differences',
        'Language' => 'English',
        'Runtime' => 123 }
    end

    before do
      allow(subject).to receive(:omdb_adapter).and_return(dummy_omdb_adapter)
      allow(dummy_omdb_adapter).to receive(:fetch_response).and_return(response)
      allow(response).to receive(:parsed_response).and_return(response_body)
    end

    it 'updates the movie record' do
      subject.perform
      expect(movie.reload).to have_attributes(runtime: 123, year: 2004, language: 'English', genre: 'Drama, Romance')
    end

    it 'calls the UpdateMovie::EntryPoint' do
      expect(UpdateMovie::EntryPoint).to receive(:new)

      subject.perform
    end
  end

  # context 'testing memoization of omdb adapter' do
  #
  #   before do
  #     allow(Omdb::ApiAdapter).to receive(:new)
  #   end
  #
  #
  #   it 'uses memoization in subsequent calls to Omdb::ApiAdapter' do
  #     expect(Omdb::ApiAdapter).to receive(:new).once.and_call_original
  #
  #     subject.perform
  #   end
  # end
end
