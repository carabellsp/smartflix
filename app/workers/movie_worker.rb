# frozen_string_literal: true

require_relative '../api/omdb/api_adapter'

class MovieWorker
  include Sidekiq::Worker
  sidekiq_options retry: false, queue: 'movies'
  attr_reader :response, :omdb_adapter

  def perform(title)
    return if Movie.find_by(title: title)

    # we do not want to generate multiple instances of the same movie

    @response = omdb_adapter.fetch_response(title)

    movie = create_movie

    movie_attributes[:actors].split(', ').each do |actor_name|
      ActiveRecord::Base.transaction do
        # wrapped the create methods in a transaction to ensure it rolls back if not fully completing
        new_actor = Actor.find_or_create_by(full_name: actor_name) do |actor|
          # use this find_or_create_by method to avoid duplicate actor creation
          actor.first_name = actor_name.split[0]
          actor.last_name = actor_name.split[-1]
        end
        new_actor.credits.create!(movie: movie)
      end
    end
  end

  private

  def omdb_adapter
    @omdb_adapter ||= Omdb::ApiAdapter.new
  end

  def create_movie
    Movie.create!(title: movie_attributes[:title],
                  year: movie_attributes[:year].to_i,
                  released: movie_attributes[:released],
                  genre: movie_attributes[:genre],
                  director: movie_attributes[:director],
                  plot: movie_attributes[:plot],
                  language: movie_attributes[:language],
                  runtime: movie_attributes[:runtime])
  end

  def movie_attributes
    @response.transform_keys! { |k| k.downcase.to_sym }
  end
end

# response = HTTParty.get("http://www.omdbapi.com/?apikey=#{API_KEY}&t=#{title}")

# MovieWorker.perform_async
# MovieWorker.new.perform(title)
# remember to be running `bundle exec sidekiq`
