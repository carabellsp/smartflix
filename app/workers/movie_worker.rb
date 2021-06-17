# require 'faker'

class MovieWorker
  include Sidekiq::Worker
  sidekiq_options retry: false, queue: 'movies'

  # alternative way:

  # def perform
  #   100.times do
  #     Movie.create!(title: Faker::Movie.title)
  #   end
  # end

  def perform
    title = Faker::Movie.title
    response = HTTParty.get("http://www.omdbapi.com/?apikey=#{ENV['OMDB_API_KEY']}&t=#{title}")

    movie = Movie.create!(title: response['Title'], year: response['Year'], released: response['Released'],
                          genre: response['Genre'], director: response['Director'], plot: response['Plot'],
                          language: response['Language'], runtime: response['Runtime'])

    response['Actors'].split(',').each do |actor|
      actor = Actor.create!(full_name: actor, first_name: actor.split[0], last_name: actor.split[-1])
      actor.credits.create!(movie: movie)

  end
  end

  # response = HTTParty.get("http://www.omdbapi.com/?apikey=#{API_KEY}&t=#{title}")

  MovieWorker.perform_async
