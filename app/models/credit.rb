class Credit < ApplicationRecord
  belongs_to :movie
  belongs_to :actor
end
