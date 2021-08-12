# frozen_string_literal: true

require 'faker'
require 'httparty'

module Omdb
  class ApiAdapter
    def fetch_data(title = nil)
      title = movie_title if title.nil?
      base_uri = "http://www.omdbapi.com/?apikey=#{ENV['OMDB_API_KEY']}"
      response = HTTParty.get("#{base_uri}&t=#{title}")

      if response.body.include?('False')
        Rails.logger.warn "This movie '#{title}' requested at #{Time.current} has returned an error in the response"
      else
        response
      end
    end

    def movie_title
     Faker::Movie.title
    end
  end
end
