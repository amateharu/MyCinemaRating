require 'rails_helper'
require 'spec_helper'

RSpec.configure do |config|
  config.before(:each) do
    stub_request(:get, 'http://www.omdbapi.com/?apikey=3a1e1da4&i=tt3896198&t=Blade%20Runner').
      with(headers: { 'Connection'=>'close',
                      'Host'=>'www.omdbapi.com',
                        'User-Agent'=>'http.rb/4.4.1'
                        }).
      to_return(status: 200, body: {"Title":"Blade Runner",
                                    "Director":"Ridley Scott",
                                    "Actors":"Harrison Ford, Rutger Hauer, Sean Young, Edward James Olmos",
                                    "Plot":"A blade runner must pursue and terminate four replicants who stole a ship in space, and have returned to Earth to find their creator.",
                                    "Poster":"https://m.media-amazon.com/images/M/MV5BNzQzMzJhZTEtOWM4NS00MTdhLTg0YjgtMjM4MDRkZjUwZDBlXkEyXkFqcGdeQXVyNjU0OTQ0OTY@._V1_SX300.jpg",
                                    "imdbRating":"8.1"
                                    }.to_json, 
                                    headers: {})
  end
end

RSpec.describe ImdbService, type: :model do
  let(:title) { 'Blade+Runner' }
  let(:description) {
                      'A blade runner must pursue and terminate four replicants '\
                      'who stole a ship in space, and have returned to Earth to find their creator.'
                    }
  let(:rating) { 8.1 }
  let(:cover) {
                'https://m.media-amazon.com/images/M/MV5BNzQzMzJhZTEtOWM4NS00MTdh'\
                'LTg0YjgtMjM4MDRkZjUwZDBlXkEyXkFqcGdeQXVyNjU0OTQ0OTY@._V1_SX300.jpg'
              }
  let(:actors) { 'Harrison Ford, Rutger Hauer, Sean Young, Edward James Olmos' }
  let(:director) { 'Ridley Scott' }

  it 'should return description of the movie' do
    expect(ImdbService.response(title)['Plot']).to eq(description)
  end

  it 'should return IMDB rating of the movie' do
    expect(ImdbService.response(title)['imdbRating'].to_f).to eq(rating)
  end

  it 'should return movie cover link' do
    expect(ImdbService.response(title)['Poster']).to eq(cover)
  end

  it 'should return actors of the movie' do
    expect(ImdbService.response(title)['Actors']).to eq(actors)
  end

  it 'should return a director of the movie' do
    expect(ImdbService.response(title)['Director']).to eq(director)
  end
end
