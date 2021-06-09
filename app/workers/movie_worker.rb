# require 'faker'

class MovieWorker
  include Sidekiq::Worker
  sidekiq_options retry: false, queue: 'movies'

  # def perform
  #   100.times do
  #     Movie.create!(title: Faker::Movie.title)
  #   end
  # end

  def perform(movies)
    movies.each do |movie|
      Movie.create(title: movie[:title])
    end
  end
end
