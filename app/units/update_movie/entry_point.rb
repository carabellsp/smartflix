# frozen_string_literal: true

module UpdateMovie
  # Calls action which updates movie instance from OMDB response
  class EntryPoint
    include ::BaseEntryPoint

    def initialize
      @action = UpdateMovie::Action.new
    end
  end
end
