# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

--------

### STILL TO DO:
- extract movie_worker logic to unit? *ADD TESTS*
- specs for `api_adapter.rb` - [written but need to get working!! config issues?!]
- secure API key (think this is done by placing it in env file and having `.env` in `gitignore`?)
- set up different API key for test env - not sure how to do this ?? 
- Write tests for missing part of the flow & check using `simplecov`
- Add update movie logic, maybe in a unit? 
- Update existing movies at 7am daily (sidekiq worker for scheduling, calling the update_movie unit)
- `Destroy movie` unit which removes instances if they haven't been updated in 48 hours
- add error message for when movie already exists
- write README
- finish building movie factory
