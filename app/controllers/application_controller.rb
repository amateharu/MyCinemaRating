class ApplicationController < ActionController::Base
  helper_method :average_rating
  helper_method :check_rating?

  # returns average rating for film
  def average_rating
    film_rating = @film.ratings.where(film_id: @film.id)

    @average_rating = film_rating.sum(:user_rating).to_f / film_rating.size
  end
  
  # if user don't rate film, @rating = true
  def check_rating?
    film_rating = @film.ratings.where(film_id: @film.id)
    user_rating = film_rating.where(user_id: current_user.id)
    
    @rating = user_rating.empty?
  end

  # set Ransack search object - @q
  def set_search
    @q = Film.search(params[:q])
  end
end
