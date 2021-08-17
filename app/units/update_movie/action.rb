# frozen_string_literal: true

module UpdateMovie
  # Service to update movie instance
  class Action < CreateMovie::Action
    def call(response, movie)
      if response_valid?(response)
        movie_attributes = transform_movie_attributes(response.parsed_response)
        update_movie(movie_attributes, movie)
      else
        log_error
      end
    end

    private

    def update_movie(attributes_to_update, movie)
      movie.update!(attributes_to_update)
    end
  end
end
