# frozen_string_literal: true

class Movie < ApplicationRecord
  validates :title, presence: true, uniqueness: true

  has_many :credits
  has_many :actors, through: :credits

  scope :outdated, -> { where('updated_at < ?', 48.hours.ago) }
end
