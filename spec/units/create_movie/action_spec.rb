# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CreateMovie::Action do
  subject { described_class.new.call(response) }

  let(:response) { instance_double(HTTParty::Response, body: response_body) }

  let(:response_body) do
    { 'Title' => 'The Notebook',
      'Year' => 2004,
      'Released' => 'Fri, 25 Jun 2004',
      'Genre' => 'Drama, Romance',
      'Director' => 'Nick Cassavetes',
      'Actors' => 'Rachel McAdams, Ryan Gosling',
      'Plot' => 'A poor yet passionate young man falls in love with a rich young woman, giving her a        sense of freedom, but they are soon separated because of their social differences',
      'Language' => 'English',
      'Runtime' => 123 }
  end

  before do
    allow(response).to receive(:parsed_response).and_return(response_body)
  end

  context 'when response is valid' do
    it 'adds the movie to the db' do
      expect { subject }.to change(Movie, :count).by(1)
    end

    it 'adds the movie with the correct attributes' do
      expect(subject).to have_attributes(title: 'The Notebook', year: 2004, released: 'Fri, 25 Jun 2004'.to_datetime, genre: 'Drama, Romance', language: 'English', runtime: 123 )
    end
  end

  context 'when response is invalid' do
    let(:response_body) { '{"Response":"False"}' }

    it 'does not create a new movie record' do
      expect { subject }.to_not change(Movie, :count)
    end

    it 'logs a Rails warning with timestamp' do
      expect(Rails.logger).to receive(:warn).with("The request at #{Time.current} has returned an error in the response")
      subject
    end
  end
end
