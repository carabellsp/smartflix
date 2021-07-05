# frozen_string_literal: true

class MovieWorker
  include Sidekiq::Worker
  sidekiq_options retry: false, queue: 'movies'
  attr_reader :response

  def perform(title)
    return if Movie.find_by(title: title)
    # we do not want to generate multiple instances of the same movie

    base_uri = "http://www.omdbapi.com/?apikey=#{ENV['OMDB_API_KEY']}"
    @response = HTTParty.get("#{base_uri}&t=#{title}")

    movie = Movie.create!(title: movie_attributes[:title],
                          year: movie_attributes[:year].to_i,
                          released: movie_attributes[:released],
                          genre: movie_attributes[:genre].split(', '),
                          director: movie_attributes[:director],
                          plot: movie_attributes[:plot],
                          language: movie_attributes[:language],
                          runtime: movie_attributes[:runtime])

    movie_attributes[:actors].split(', ').each do |actor_name|
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

  def movie_attributes
    @response.transform_keys! { |k| k.downcase.to_sym }
  end
end

# response = HTTParty.get("http://www.omdbapi.com/?apikey=#{API_KEY}&t=#{title}")

# MovieWorker.perform_async
# MovieWorker.new.perform(title)
