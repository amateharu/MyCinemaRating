require 'rails_helper'

RSpec.describe 'Films', type: :request do
  let(:film) { Film.create(title: 'Gladiator') }

  it 'it renders index page' do
    get '/films/'
    expect(response).to be_successful
    expect(response.body).to include('Gladiator')
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
end
