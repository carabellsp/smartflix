# frozen_string_literal: true

require 'sidekiq-scheduler'

class DestroyMovieWorker
  include Sidekiq::Worker

  sidekiq_options queue: :movies, retry: false

  def perform
    movies = Movie.where('updated_at < ?', 48.hours.ago)
    movies.each do |movie|
      DestroyMovie::EntryPoint.new(movie)
    end
  end
end

# https://stackoverflow.com/questions/23563439/how-to-find-record-depending-upon-the-updated-at-in-rails
