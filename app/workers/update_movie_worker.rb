# frozen_string_literal: true

require 'sidekiq-scheduler'

# Sidekiq Worker to Update Movie Instances (scheduled everyday at 7am)
class UpdateMovieWorker
  include Sidekiq::Worker

  sidekiq_options retry: false, queue: 'movies'

  def perform
    Movie.find_each do |movie|
      response = omdb_adapter.fetch_response(movie.title)
      UpdateMovie::EntryPoint.new.call(response, movie)
    end
  end

  private

  def omdb_adapter
    @omdb_adapter ||= Omdb::ApiAdapter.new
  end
end
