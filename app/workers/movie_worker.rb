# require 'faker'

class MovieWorker
  include Sidekiq::Worker
  sidekiq_options retry: false, queue: 'movies'

  # def perform(*args)
  #   100.times do
  #     movie = Movie.new(title: Faker::Movie.title)
  #     movie.save
  #   end
  # end

  def perform(movies)
    movies.each do |movie|
      Movie.create(title: movie[:title])
    end
  end
end
