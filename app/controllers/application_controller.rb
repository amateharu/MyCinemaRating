class ApplicationController < ActionController::Base
  helper_method :average_rating
  helper_method :check_rating?

  def average_rating
    @average_rating = @film.ratings.sum(:user_rating).to_f / @film.ratings.size
  end

  def check_rating?
    @rating = @film.ratings.empty?
  end
end
