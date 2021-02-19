require 'rails_helper'
require 'uri'

RSpec.describe Film, type: :model do
  subject { Film.new(title: 'Blade Runner', user_id: 1) }

  it 'should be valid with valid attributes' do
    expect(subject).to be_valid
  end

  it 'should not be valid without title' do
    subject.title = nil
    expect(subject).to_not be_valid
  end

  it 'should not be valid with title under 3 symbols' do
    subject.title = 'Bl'
    expect(subject).to_not be_valid
  end

  it 'should not be valid with too long title' do
    subject.title = 'B' * 21
    expect(subject).to_not be_valid
  end

  it 'should be not be valid with non-unique title' do
    subject.save
    movie = Film.new(title: 'Blade Runner')
    expect(movie).to_not be_valid
  end

  it 'should be able to accept the parsed description' do
    subject.description = ImdbService.response(CGI.escape(subject.title))['Plot']
    expect(subject.description).to_not eq(nil)
  end

  it 'should be able to accept the parsed image' do
    subject.image = ImdbService.response(CGI.escape(subject.title))['Poster']
    expect(subject.image).to_not eq(nil)
  end

  it 'should be able to accept the parsed director' do
    subject.director = ImdbService.response(CGI.escape(subject.title))['Director']
    expect(subject.director).to_not eq(nil)
  end

  it 'should be able to accept the parsed actors' do
    subject.actors = ImdbService.response(CGI.escape(subject.title))['Actors']
    expect(subject.actors).to_not eq(nil)
  end

  it 'should be able to accept the parsed IMDB rating' do
    subject.imdb_rating = ImdbService.response(CGI.escape(subject.title))['imdbRating']
    expect(subject.imdb_rating).to_not eq(nil)
  end
end
