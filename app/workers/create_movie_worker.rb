# frozen_string_literal: true

# Sidekiq Worker to Create Movie Instances
class CreateMovieWorker
  include Sidekiq::Worker

  sidekiq_options retry: false, queue: 'movies'

  def perform(title)
    response = omdb_adapter.fetch_response(title)
    CreateMovie::EntryPoint.new.call(response)
  end

  private

  def omdb_adapter
    @omdb_adapter ||= Omdb::ApiAdapter.new
  end
end

# How to manually execute worker:
# CreateMovieWorker.perform_async
# CreateMovieWorker.new.perform(title)
# remember to be running `bundle exec sidekiq`
