class AddMovieToCredits < ActiveRecord::Migration[6.1]
  def change
    add_reference :credits, :movie, null: false, foreign_key: true
  end
end
