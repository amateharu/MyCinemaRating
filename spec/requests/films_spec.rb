require 'rails_helper'
require 'spec_helper'

RSpec.configure do |config|
  config.before(:each) do
    stub_request(:get, 'http://www.omdbapi.com/?apikey=3a1e1da4&i=tt3896198&t=Blade%20Runner')
      .with(headers: { 'Connection' => 'close',
                       'Host' => 'www.omdbapi.com',
                       'User-Agent' => 'http.rb/4.4.1' })
      .to_return(status: 200,
                 body: { 'Title': 'Blade Runner',
                         'Director': 'Ridley Scott',
                         'Actors': 'Harrison Ford, Rutger Hauer, Sean Young, Edward James Olmos',
                         'Plot': 'A blade runner must pursue and terminate four replicants who stole a ship in space, and have returned to Earth to find their creator.',
                         'Poster': 'https://m.media-amazon.com/images/M/MV5BNzQzMzJhZTEtOWM4NS00MTdhLTg0YjgtMjM4MDRkZjUwZDBlXkEyXkFqcGdeQXVyNjU0OTQ0OTY@._V1_SX300.jpg',
                         'imdbRating': '8.1' }.to_json,
                 headers: {})
  end
end

RSpec.describe 'Films', type: :request do
  let(:film) { Film.create(title: 'Blade Runner') }

  it 'it renders index page' do
    film.save
    get '/films/'
    expect(response).to be_successful
    expect(response.body).to include('Blade Runner')
  end

  it 'renders a new template' do
    get '/films/new'
    expect(response).to be_successful
  end

  it 'renders an edit template' do
    get "/films/#{film.id}"
    expect(response).to be_successful
  end

  it 'renders a film template' do
    get "/films/#{film.id}"
    expect(response).to be_successful
  end

  context 'ransack searching and sorting' do
    let!(:film2) { Film.create(title: 'Matrix', imdb_rating: 4) }
    before { get films_path, params: { q: { title_cont: 'Matrix' } } }

    it 'returns the found movie as first instance' do
      expect(assigns(:films).first).to eq(film2)
      expect(response).to be_successful
      expect(:films).to render_template(:index)
    end
  end
end
