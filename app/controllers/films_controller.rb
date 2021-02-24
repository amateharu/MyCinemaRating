# Creates, show, update and delete articles
class FilmsController < ApplicationController
  before_action :find_film, only: %i[show update edit destroy]
  before_action :film_attributes, only: %i[show]
  before_action :average_rating, only: %i[show]

  def new
    @film = Film.new
  end

  def create
    @film = Film.new(film_params)
    if @film.save
      redirect_to @film
    else
      render 'new'
    end
  end

  def index
    @films = Film.all
  end

  def show
    @rating = Rating.new(film_id: @film.id)
  end

  def edit; end

  def update
    if @film.update(film_params)
      redirect_to @film
    else
      render 'edit'
    end
  end

  def destroy
    @film.destroy
    redirect_to films_path
  end

  private

  def film_params
    params.require(:film).permit(:title)
  end

  def find_film
    @film = Film.find(params[:id])
  end

  def film_attributes
    @film.description = ImdbService.response(CGI.escape(@film.title))['Plot']
    @film.image = ImdbService.response(CGI.escape(@film.title))['Poster']
    @film.director = ImdbService.response(CGI.escape(@film.title))['Director']
    @film.actors = ImdbService.response(CGI.escape(@film.title))['Actors']
    @film.imdb_rating = ImdbService.response(CGI.escape(@film.title))['imdbRating']
    @film.save
  end
end
