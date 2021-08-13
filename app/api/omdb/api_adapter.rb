# frozen_string_literal: true

require 'faker'
require 'httparty'

# Service to parse response from OMDB Api
module Omdb
  class ApiAdapter
    def fetch_response(title = nil)
      title = movie_title if title.nil?
      base_uri = "http://www.omdbapi.com/?apikey=#{ENV['OMDB_API_KEY']}"
      uri = "#{base_uri}&t=#{title}"
      response = HTTParty.get(uri)

      if response.body.include?('False')
        log_error
      else
        response
      end
    end

    def movie_title
      Faker::Movie.title
    end

    def log_error
      Rails.logger.warn "This movie '#{title}' requested at #{Time.current} has returned an error in the response"
    end
  end
end
