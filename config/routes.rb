Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  get 'sessions/new'
  root             'static_pages#home'
  get 'about'   => 'static_pages#about'
  get 'signup'  => 'users#new'
  get    'login'   => 'sessions#new'
  post   'login'   => 'sessions#create'
  delete 'logout'  => 'sessions#destroy'
  
  resources :users do
    resources :films
  end

  resources :films do
    resources :comments, only: [:create]
  end

  resources :films do
    resources :ratings, only: %i[new create update]
  end
end
