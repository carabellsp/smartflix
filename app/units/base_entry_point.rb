# frozen_string_literal: true

module BaseEntryPoint
  def call(*args)
    @action.call(*args)
  end
end
