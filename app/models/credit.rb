# frozen_string_literal: true

class Credit < ApplicationRecord
  belongs_to :movie
  belongs_to :actor
end
