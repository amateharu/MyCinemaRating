# frozen_string_literal: true

# Creates, show, update and delete articles
class FilmsController < ApplicationController
  include SessionsHelper
  before_action :find_film, only: %i[show update edit destroy]
  before_action :default_attributes, only: %i[show]
  before_action :average_rating, only: %i[show]
  before_action :require_user, only: %i[show]
  before_action :check_rating?, only: %i[show]
  before_action :set_search

  def new
    @film = current_user.films.new
  end

  def create
    @film = current_user.films.new(film_params)
    if @film.save
      redirect_to @film
    else
      render 'new'
    end
  end

  def index
    @q ||= Film.ransack(params[:q])
    @films = @q.result(distinct: true).where(published: true).paginate(page: params[:page], per_page: 8).order('id DESC')
  end

  def show; end

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

  # fetching default attributes for film
  def default_attributes
    service = ImdbService.response(CGI.escape(@film.title))

    @img = @film.image
    @imdb = service['imdbRating'] || ''
    @votes = ImdbService.response(CGI.escape(@film.title))['imdbVotes'] || ''
    @year = service['Year'] || 'N/A'
    @runtime = service['Runtime'] || 'N/A'
    @genre = service['Genre'] || 'N/A'
    @director = service['Director'] || 'N/A'
    @actors = service['Actors'] || 'N/A'
    @country = service['Country'] || ''
    @box_office = service['BoxOffice'] || ''
    @awards = service['Awards'] || ''
    @description = service['Plot'] || ''
  end
end
