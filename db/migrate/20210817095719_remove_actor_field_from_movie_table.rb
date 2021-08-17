# frozen_string_literal: true

class RemoveActorFieldFromMovieTable < ActiveRecord::Migration[6.1]
  def change
    remove_column :movies, :actors, :string
  end
end
