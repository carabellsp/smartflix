# frozen_string_literal: true

class CreateMovieWorker
  include Sidekiq::Worker

  sidekiq_options retry: false, queue: 'movies'
  attr_reader :omdb_adapter

  def perform(title)
    return if Movie.find_by(title: title) # we do not want to generate multiple instances of the same movie

    response = omdb_adapter.fetch_response(title)
    CreateMovie::EntryPoint.new(response)
  end

  private

  def omdb_adapter
    @omdb_adapter ||= Omdb::ApiAdapter.new
  end
end

# response = HTTParty.get("http://www.omdbapi.com/?apikey=#{API_KEY}&t=#{title}")

# CreateMovieWorker.perform_async
# CreateMovieWorker.new.perform(title)
# remember to be running `bundle exec sidekiq`
