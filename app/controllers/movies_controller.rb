class MoviesController < ApplicationController

  def show
    title = params[:title]

    @movie = Movie.find_by(title: title)

    if @movie
      render json: @movie
    else
      MovieWorker.perform_async(title)
      render json: {:error => "We do not yet have this movie :("}.to_json,
             status: 404
    end
  end
end
