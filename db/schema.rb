# frozen_string_literal: true

# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20_210_617_124_615) do
  # These are extensions that must be enabled in order to support this database
  enable_extension 'plpgsql'

  create_table 'actors', force: :cascade do |t|
    t.string 'full_name'
    t.string 'first_name'
    t.string 'last_name'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
  end

  create_table 'credits', force: :cascade do |t|
    t.bigint 'movie_id', null: false
    t.bigint 'actor_id', null: false
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index ['actor_id'], name: 'index_credits_on_actor_id'
    t.index ['movie_id'], name: 'index_credits_on_movie_id'
  end

  create_table 'movies', force: :cascade do |t|
    t.string 'title'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.integer 'year'
    t.date 'released'
    t.string 'genre'
    t.string 'director'
    t.string 'actors'
    t.string 'plot'
    t.string 'language'
    t.integer 'runtime'
  end

  add_foreign_key 'credits', 'actors'
  add_foreign_key 'credits', 'movies'
end
