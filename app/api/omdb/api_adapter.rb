# frozen_string_literal: true

require 'faker'
require 'httparty'

module Omdb
  class ApiAdapter
    def fetch_data(title = nil)
      title = movie_title if title.nil?
      base_uri = "http://www.omdbapi.com/?apikey=#{ENV['OMDB_API_KEY']}"
      HTTParty.get("#{base_uri}&t=#{title}")
    end

    def movie_title
     Faker::Movie.title
    end
  end
end
