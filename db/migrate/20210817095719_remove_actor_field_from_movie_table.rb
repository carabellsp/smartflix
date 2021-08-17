# frozen_string_literal: true

# Migration to remove actors column from movies table
class RemoveActorFieldFromMovieTable < ActiveRecord::Migration[6.1]
  def change
    remove_column :movies, :actors, :string
  end
end
