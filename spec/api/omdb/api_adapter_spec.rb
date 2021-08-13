require 'rails_helper'

RSpec.describe Omdb::ApiAdapter do
  describe '#fetch_response' do

    context 'when title is provided' do
      let(:title) { 'Home Alone' }

      it 'makes a request and returns the correct HTTP response' do
        VCR.use_cassette 'fetch_home_alone' do
          response = subject.fetch_response(title)
          expect(response).to be_a_kind_of HTTParty::Response
          expect(response[:title]).to eq('Home Alone')
        end
      end
    end

    context 'when no title is provided' do
      subject { described_class.new }

      it 'makes a request and returns an HTTP response' do
        allow(described_class.new).to receive(:movie_title).and_return('Batman')

        VCR.use_cassette 'fetch_batman' do
          response = subject.fetch_response
          expect(response).to be_a_kind_of HTTParty::Response
          expect(response['Title']).to eq('Batman')
        end

      end
    end
  end
end
