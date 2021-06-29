# frozen_string_literal: true

class AddActorToCredits < ActiveRecord::Migration[6.1]
  def change
    add_reference :credits, :actor, null: false, foreign_key: true
  end
end
