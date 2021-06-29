# frozen_string_literal: true

class AddColumnsToMovies < ActiveRecord::Migration[6.1]
  def change
    add_column :movies, :year, :integer
    add_column :movies, :released, :date
    add_column :movies, :genre, :string
    add_column :movies, :director, :string
    add_column :movies, :actors, :string
    add_column :movies, :plot, :string
    add_column :movies, :language, :string
    add_column :movies, :runtime, :integer
  end
end
