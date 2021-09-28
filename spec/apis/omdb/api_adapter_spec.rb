# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Omdb::ApiAdapter do
  context 'when title is provided' do
    subject { described_class.new }

    let(:title) { 'Shrek' }

    it 'makes a request and returns the correct HTTP response', :aggregate_failures do
      VCR.use_cassette 'fetch_shrek' do
        response = subject.fetch_response(title)
        expect(response).to be_a_kind_of HTTParty::Response
        expect(response['Title']).to eq('Shrek')
      end
    end
  end

  context 'when no title is provided' do
    subject { described_class.new }

    it 'makes a request and returns an HTTP response', :aggregate_failures do
      allow(subject).to receive(:movie_title).and_return('Batman')

      VCR.use_cassette 'fetch_batman' do
        response = subject.fetch_response
        expect(response).to be_a_kind_of HTTParty::Response
        expect(response['Title']).to eq('Batman')
      end
    end
  end

  describe '#movie_title' do
    subject { described_class.new.movie_title }

    it 'generates a random movie title' do
      allow(Faker::Movie).to receive(:title).and_return('Inception')

      expect(subject).to eq('Inception')
    end
  end
end
