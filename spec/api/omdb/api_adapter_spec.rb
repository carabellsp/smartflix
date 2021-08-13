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
  end
end
