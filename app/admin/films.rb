# frozen_string_literal: true

ActiveAdmin.register Film do
  permit_params :title, :description, :image, :director, :actors, :imdb_rating, :user_id, :published

  action_item :publish, only: :show do
    link_to 'Publish', publish_admin_film_path(film), method: :put unless film.published?
  end

  action_item :unpublish, only: :show do
    link_to 'Unpublish', unpublish_admin_film_path(film), method: :put if film.published?
  end

  member_action :publish, method: :put do
    film = Film.find(params[:id])
    film.update(published: true)
    redirect_to admin_film_path(film)
  end

  member_action :unpublish, method: :put do
    film = Film.find(params[:id])
    film.update(published: false)
    redirect_to admin_film_path(film)
  end
end
