Rails.application.routes.draw do
  devise_for :users, :controllers => { registrations: 'registrations' }

  root 'pages#home', page: "home"
  get '/dashboard', to: 'pages#dashboard'
  get "/home", to: 'pages#home'

  resources :users do
    resources :exercises
  end
end
