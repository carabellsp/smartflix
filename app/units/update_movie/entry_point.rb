# frozen_string_literal: true

module UpdateMovie
  # Calls action which updates movie instance from OMDB response
  class EntryPoint
    def initialize(response, movie)
      @action = UpdateMovie::Action.new.call(response, movie)
    end
  end
end
