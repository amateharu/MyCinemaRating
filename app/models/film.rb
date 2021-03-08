# frozen_string_literal: true

# Film model
class Film < ApplicationRecord
  belongs_to :user
  has_many :ratings, dependent: :destroy
  has_many :comments, -> { order(created_at: :desc) }, dependent: :destroy
  validates :title, presence: true,
                    length: {
                      minimum: 3,
                      maximum: 50
                    },
                    uniqueness: { case_sensitive: false }

  before_save :fetch_film_credentials, on: :create

  # calculate the IMDb rating into stars
  def imdb_stars(imdb_rating)
    imdb = (10 - imdb_rating.to_i).to_f / 2
    5 - imdb
  end

  private

  def film_data_for_nil_response
    self.title = '---'
    self.description = 'N/A'
    # default image name 'movies-app'. Put your name here.
    self.image = ENV['DEFAULT_IMAGE']
    self.director = 'N/A'
    self.actors = 'N/A'
    self.imdb_rating = 0
  end

  def check_image(img)
    if img.match?('https')
      img
    else
      ENV['DEFAULT_IMAGE']
    end
  end

  def fetch_film_credentials
    response = ImdbService.response(CGI.escape(title))['Title']
    
    return film_data_for_nil_response if response.nil?
      
    self.title = ImdbService.response(CGI.escape(title))['Title']
    self.description = ImdbService.response(CGI.escape(title))['Plot']
    self.image = check_image ImdbService.response(CGI.escape(title))['Poster']
    self.director = ImdbService.response(CGI.escape(title))['Director']
    self.actors = ImdbService.response(CGI.escape(title))['Actors']
    self.imdb_rating = ImdbService.response(CGI.escape(title))['imdbRating']
  end
end
