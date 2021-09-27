# frozen_string_literal: true

require 'sidekiq-scheduler'

class DestroyMovieWorker
  include Sidekiq::Worker

  sidekiq_options queue: :movies, retry: false

  def perform
    movies = Movie.outdated
    movies.destroy_all
  end
end


# https://stackoverflow.com/questions/23563439/how-to-find-record-depending-upon-the-updated-at-in-rails
