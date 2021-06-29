# frozen_string_literal: true

class MovieWorker
  include Sidekiq::Worker
  sidekiq_options retry: false, queue: 'movies'

  def perform
    title = Faker::Movie.title
    return if Movie.find_by(title: title)

    # because we are using Faker, we do not want to generate multiple instances of the same movie

    base_uri = "http://www.omdbapi.com/?apikey=#{ENV['OMDB_API_KEY']}"
    response = HTTParty.get("#{base_uri}&t=#{title}")

    movie = Movie.create!(title: response['Title'], year: response['Year'], released: response['Released'],
                          genre: response['Genre'].split(', '), director: response['Director'], plot: response['Plot'],
                          language: response['Language'], runtime: response['Runtime'])

    response['Actors'].split(', ').each do |actor_name|
      ActiveRecord::Base.transaction do
        # wrapped the create methods in a transaction to ensure it rolls back if not fully completing
        actor = Actor.find_or_create_by(full_name: actor_name) do |actor|
          # use this find_or_create_by method to avoid duplicate actor creation
          actor.first_name = actor_name.split[0]
          actor.last_name = actor_name.split[-1]
        end
        actor.credits.create!(movie: movie)
      end
    end
  end
end

# response = HTTParty.get("http://www.omdbapi.com/?apikey=#{API_KEY}&t=#{title}")

# MovieWorker.perform_async
