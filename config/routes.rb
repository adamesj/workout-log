Rails.application.routes.draw do
  devise_for :users, :controllers => { registrations: 'registrations' }

  root 'pages#home', page: "home"
  get '/home', to: 'pages#home'

  resources :pages, only: [:show] do
    collection do
      get :search, to: 'pages#search'
    end
  end

  resources :users do
    resources :exercises
  end

  resources :friendships, only: [:show, :create, :destroy]
  resources :messages, only: [:create]

  mount ActionCable.server => '/cable'
end
