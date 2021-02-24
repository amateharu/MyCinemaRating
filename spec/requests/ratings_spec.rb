require 'rails_helper'

RSpec.describe 'Ratings', type: :request do
  let(:rating) { Rating.create(user_rating: 5) }
  let(:film) { Film.create(title: 'testmovie', ratings: [rating]) }

  it 'accepts the rating from user and redirects to film page' do
    post "/films/#{film.id}/ratings", params: { rating: { user_rating: 4 } }
    expect(response).to redirect_to(film)
  end
end
