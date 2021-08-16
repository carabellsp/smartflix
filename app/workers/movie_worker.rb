# frozen_string_literal: true

require_relative '../api/omdb/api_adapter'

class MovieWorker
  include Sidekiq::Worker

  sidekiq_options retry: false, queue: 'movies'
  attr_reader :omdb_adapter

  def perform(title)
    return if Movie.find_by(title: title)  # we do not want to generate multiple instances of the same movie

    response = omdb_adapter.fetch_response(title)
    CreateMovie::EntryPoint.new(response)

  end

  private

  def omdb_adapter
    @omdb_adapter ||= Omdb::ApiAdapter.new
  end
end

# response = HTTParty.get("http://www.omdbapi.com/?apikey=#{API_KEY}&t=#{title}")

# MovieWorker.perform_async
# MovieWorker.new.perform(title)
# remember to be running `bundle exec sidekiq`
