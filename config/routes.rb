Rails.application.routes.draw do
  devise_for :users

  root 'pages#show', page: "home"

  get "/pages/*page" => "pages#show"

  resources :users do
    resources :exercises
  end
end
