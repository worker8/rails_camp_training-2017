Rails.application.routes.draw do
  root to: "homes#show"
  # get "/" => "homes#show" # same as above, but above is preferred

  resource :session, only: [:new, :create, :destroy]
  resources :users, only: [:new, :create, :show] do
    member do
      post "follow" => "follows#create"
      post "unfollow" => "follows#destroy"
    end
  end
  resources :recipes, only: [:show]
  namespace :my do
    resources :recipes, only: %i(new create edit destroy update)
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
