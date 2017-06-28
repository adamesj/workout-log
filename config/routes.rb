Rails.application.routes.draw do
  devise_for :users, :controllers => { registrations: 'registrations' }

  root 'pages#show', page: "home"

  get "/pages/*page" => "pages#show"

  resources :users do
    resources :exercises
  end
end
