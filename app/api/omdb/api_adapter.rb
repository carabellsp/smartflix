# frozen_string_literal: true

require 'faker'
require 'httparty'

module Omdb
  # Service to parse response from OMDB Api
  class ApiAdapter
    def fetch_response(title = nil)
      title = movie_title if title.nil?
      base_uri = "http://www.omdbapi.com/?apikey=#{ENV['OMDB_API_KEY']}"
      uri = "#{base_uri}&t=#{title}"
      HTTParty.get(uri)
    end

    def movie_title
      Faker::Movie.title
    end
  end
end
