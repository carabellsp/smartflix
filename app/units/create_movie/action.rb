# frozen_string_literal: true

module CreateMovie
  class Action
    def call(response)
      if response_valid?(response)
        movie_attributes = transform_movie_attributes(response.parsed_response)

        create_movie(movie_attributes).tap { |movie| create_actors(movie, movie_attributes) }
      else
        log_error
      end
    end

    private

    def response_valid?(response)
      !response.body.include?('False')
    end

    def log_error
      Rails.logger.warn "The request at #{Time.current} has returned an error in the response"
    end

    def transform_movie_attributes(response)
      response.transform_keys! { |k| k.downcase.to_sym }
    end

    # is it bad to have a method with same name as module??
    def create_movie(movie_attributes)
      Movie.create!(title: movie_attributes[:title],
                    year: movie_attributes[:year].to_i,
                    released: movie_attributes[:released],
                    genre: movie_attributes[:genre],
                    director: movie_attributes[:director],
                    plot: movie_attributes[:plot],
                    language: movie_attributes[:language],
                    runtime: movie_attributes[:runtime])
    end

    def create_actors(movie, movie_attributes)
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
  end
end
