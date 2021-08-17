# frozen_string_literal: true

module CreateMovie
  # Calls action which creates movie instance from OMDB response
  class EntryPoint
    def initialize(response)
      @action = CreateMovie::Action.new.call(response)
    end
  end
end
