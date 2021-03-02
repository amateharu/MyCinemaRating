require 'rails_helper'
require 'spec_helper'

RSpec.describe 'Films', type: :feature do
  let(:film) { Film.create(title: 'Blade Runner', imdb_rating: 5) }
  let(:film2) { Film.create(title: 'Matrix', imdb_rating: 4) }
  let(:film3) { Film.create(title: 'Twilight', imdb_rating: 1) }
  let(:film4) { Film.create(title: 'X-Men', imdb_rating: 3) }

  it 'sorts movies by imdb_rating' do
    visit films_path
    click_link 'IMDB Rating'
    expect(Film.order('imdb_rating desc')).to eq([film, film2, film4, film3])
    expect(Film.order('imdb_rating desc')).to_not eq([film2, film4, film, film3])
  end
end
