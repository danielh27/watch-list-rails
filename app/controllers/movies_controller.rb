class MoviesController < ApplicationController
  def index
    @movies = Movie.all
  end

  def search
    @movie = Movie.new
  end

  def results
    query = params[:search][:query]
    url = "http://tmdb.lewagon.com/search/movie?query=#{query}"
    movies = JSON.parse(URI.open(url).read)
    @results = movies["results"]
  end

  def create
  end

end
