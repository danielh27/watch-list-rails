require 'open-uri'
require 'json'

movies = URI.open("http://tmdb.lewagon.com/movie/top_rated").read

movies = JSON.parse(movies)
movies["results"].each do |movie|

  if movie["original_language"] == "en"
    new_movie = Movie.new
    new_movie.title = movie["original_title"]
    new_movie.overview = movie["overview"]
    new_movie.poster_url = "https://image.tmdb.org/t/p/w500/#{movie["poster_path"]}"
    new_movie.rating = movie["vote_average"]
    new_movie.save
  end
end
