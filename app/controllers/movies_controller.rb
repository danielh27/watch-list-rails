require 'rest-client'

class MoviesController < ApplicationController
  def index
    @movies = Movie.all
  end

  def search
    @movie = Movie.new
  end

  def results
    query = params[:search][:query]
    response = RestClient.get "http://tmdb.lewagon.com/search/movie?query=#{query}"
    @results = JSON.parse(response.body)['results']
  end

  def create
    data = movie_params
    poster = "https://image.tmdb.org/t/p/w500/#{data['poster_path']}"
    movie = Movie.new(title: data['original_title'], overview: data['overview'], rating: data['vote_average'], poster_url: poster)

    if movie.save
      redirect_to movies_path
    else
      render :search
    end
  end

  private

  def movie_params
    params.require(:movie).permit(:original_title, :overview, :poster_path, :vote_average)
  end
end
