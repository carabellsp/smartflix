# frozen_string_literal: true

class MoviesController < ApplicationController
  def show
    title = params[:title]

    @movie = find_movie_by_title(title)

    if @movie
      render json: @movie
    else
      add_movie(title)
      render json: { error: 'We do not yet have this movie :(' }.to_json,
             status: 404
    end
  end

  def find_movie_by_title(title)
    Movie.find_by(title: title)
  end

  def add_movie(title)
    CreateMovieWorker.perform_async(title)
    # CreateMovieWorker.new.perform(title) ??
  end
end
