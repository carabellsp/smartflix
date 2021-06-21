# require 'faker'

class MovieWorker
  include Sidekiq::Worker
  sidekiq_options retry: false, queue: 'movies'

    def perform
      title = Faker::Movie.title
      return if Movie.find_by(title: title)

      response = HTTParty.get("http://www.omdbapi.com/?apikey=#{ENV['OMDB_API_KEY']}&t=#{title}")
  
      movie = Movie.create!(title: response['Title'], year: response['Year'], released: response['Released'],
                            genre: response['Genre'], director: response['Director'], plot: response['Plot'],
                            language: response['Language'], runtime: response['Runtime'])

      response['Actors'].split(', ').each do |actor_name|
        ActiveRecord::Base.transaction do
          actor = Actor.find_or_create_by(full_name: actor_name) do |actor|
            actor.first_name = actor_name.split[0]
            actor.last_name = actor_name.split[-1]
          end
          actor.credits.create!(movie: movie)
        end
      end
    end
  end

  # response = HTTParty.get("http://www.omdbapi.com/?apikey=#{API_KEY}&t=#{title}")

  MovieWorker.perform_async
