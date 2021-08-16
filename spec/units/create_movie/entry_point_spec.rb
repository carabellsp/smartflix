# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CreateMovie::EntryPoint do
  subject { described_class.new(response) }

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

  it 'adds a new movie record to the db' do
    expect { subject }.to change(Movie, :count).by(1)
  end

end
