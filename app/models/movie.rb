# frozen_string_literal: true

class Movie < ApplicationRecord
  validates :title, presence: true, uniqueness: true

  has_many :credits
  has_many :actors, through: :credits
end
