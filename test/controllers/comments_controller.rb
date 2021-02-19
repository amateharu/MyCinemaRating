# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  let(:comment) { Comment.create(body: 'test5') }

  describe 'POST #create' do
    it 'creates a new comment and redirects' do
      post :create, params: { comment: { body: 'test55' } }
      expect(response).to be_redirect
    end
  end

  describe 'GET #index' do
    it 'has a 200 status code' do
      get :index
      expect(response.status).to eq(200)
    end

    it 'renders the index template' do
      get :index
      expect(response).to render_template('index')
    end
  end

  describe 'GET #show' do
    it 'returns a success response' do
      get :show, params: { id: comment.to_param }
      expect(response.status).to eq(200)
    end

    it 'renders the show template' do
      get :show, params: { id: comment.to_param }
      expect(response).to render_template('show')
    end
  end

  describe 'GET #new' do
    it 'returns a success response' do
      get :new
      expect(response.status).to eq(200)
    end

    it 'renders the new template' do
      get :new
      expect(response).to render_template('new')
    end
  end

  describe 'GET #edit' do
    it 'returns a success response' do
      get :edit, params: { id: comment.to_param }
      expect(response.status).to eq(200)
    end

    it 'renders the edit template' do
      get :edit, params: { id: comment.to_param }
      expect(response).to render_template('edit')
    end
  end

  describe 'PATCH #update' do
    it 'updates the comment and redirects' do
      patch :update, params: { id: comment.id, comment: { body: 'test55' } }
      expect(response).to be_redirect
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the comment and redirects' do
      delete :destroy, params: { id: comment.id }
      expect(response.status).to eq(302)
    end
  end
end
