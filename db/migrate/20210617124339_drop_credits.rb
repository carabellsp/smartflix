# frozen_string_literal: true

class DropCredits < ActiveRecord::Migration[6.1]
  def change
    drop_table :credits
  end
end
