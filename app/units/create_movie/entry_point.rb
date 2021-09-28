# frozen_string_literal: true

module CreateMovie
  # Calls action which creates movie instance from OMDB response
  class EntryPoint

    include ::BaseEntryPoint

    def initialize
      @action = CreateMovie::Action.new
      # @response = response
    end

    # def call
    #   @action.call(@response)
    # end
  end
end
