class Movie < ApplicationRecord
  validates :title, presence: true

  has_many :credits
  has_many :actors, through: :credits
end
