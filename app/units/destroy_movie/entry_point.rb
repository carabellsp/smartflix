# frozen_string_literal: true

module DestroyMovie
  # Calls action to delete movie
  class EntryPoint
    def initialize(movie)
      @action = DestroyMovie::Action.new.call(movie)
    end
  end
end
