# frozen_string_literal: true

class Actor < ApplicationRecord
  validates :first_name, presence: true
  validates :last_name, presence: true

  has_many :credits
  has_many :movies, through: :credits
end
