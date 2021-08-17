# frozen_string_literal: true

module DestroyMovie
  # Action to delete a movie object
  class Action
    def call(movie)
      movie.destroy
    end
  end
end
