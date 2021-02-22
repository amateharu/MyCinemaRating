Rails.application.routes.draw do
  root 'comments#index'
  resources :comments

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :films do
    resources :ratings, only: %i[new create update]
  end
end
