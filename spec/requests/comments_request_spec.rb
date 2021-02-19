# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Comments', type: :request do
  let(:comment) { Comment.create(body: 'test55') }

  describe 'GET /index' do
    it 'returns http success' do
      get '/comments'
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /show' do
    it 'returns http success' do
      get "/comments/#{comment.id}"
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /new' do
    it 'returns http success' do
      get '/comments/new'
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST /create' do
    it 'returns http success' do
      post '/comments', params: { comment: { body: 'test555' } }
      expect(response).to redirect_to(assigns(:comment))
      follow_redirect!

      expect(response).to render_template(:show)
      expect(response.body).to include('Comment has been created!')
    end
  end

  describe 'GET /edit' do
    it 'returns http success' do
      get "/comments/#{comment.id}/edit"
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /update' do
    it 'returns http success' do
      patch "/comments/#{comment.id}", params: { comment: { body: 'test555' } }
      expect(response).to redirect_to(assigns(:comment))
      follow_redirect!

      expect(response).to render_template(:show)
      expect(response.body).to include('Comment has been updated!')
    end
  end

  describe 'GET /destroy' do
    it 'returns http success' do
      delete "/comments/#{comment.id}"
      expect(response).to have_http_status(302)
    end
  end
end
