Rails.application.routes.draw do
  devise_for :users, :controllers => { registrations: 'registrations' }

  root 'pages#home', page: "home"
  get '/dashboard', to: 'pages#dashboard'
  get '/home', to: 'pages#home'

  resources :pages, only: [:dashboard] do
    collection do
      post :search, to: 'pages#search'
    end
  end

  resources :users do
    resources :exercises
  end

  resources :friendships, only: [:show, :create, :destroy]
  resources :messages, only: [:create]
end
