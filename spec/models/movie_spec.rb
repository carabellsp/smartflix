# frozen_string_literal: true

require 'rails_helper'

describe Movie, :vcr do
  let(:movie) { HTTParty.get("http://www.omdbapi.com/?apikey=#{ENV['OMDB_API_KEY']}&t=#{title}") }
  let(:title) { 'Scarface' }

  it 'should return the correct movie' do
    expect(movie['Title']).to eq('Scarface')
    expect(movie['Year']).to eq('1983')
    expect(movie['Director']).to eq('Brian De Palma')
    expect(movie['Actors']).to include('Al Pacino')
  end
end
