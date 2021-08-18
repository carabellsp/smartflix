# frozen_string_literal: true

class MoviesController < ApplicationController
  def show
    @movie = find_movie_by_title

    if @movie
      render json: @movie
    else
      add_movie
      render json: { error: 'We do not yet have this movie :(' }.to_json,
             status: :not_found
    end
  end

  def find_movie_by_title
    Movie.find_by(title: params[:title])
  end

  def add_movie
    title = params[:title]
    CreateMovieWorker.perform_async(title)
  end
end
