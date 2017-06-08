Rails.application.routes.draw do
  root to: "homes#show"
  # get "/" => "homes#show" # same as above, but above is preferred

  resource :session, only: [:new, :create, :destroy]

  resources :recipes, only: [:show] do
    member do
      post "like" => "likes#create"
      post "unlike" => "likes#destroy"
    end

    member do
      post "bookmark" => "bookmarks#create"
      post "unbookmark" => "bookmarks#destroy"
    end

    resources :comments, only: [:create, :destroy]
  end

  resources :users, only: [:new, :create, :show] do
    member do
      post "follow" => "follows#create"
      post "unfollow" => "follows#destroy"
    end
  end

  namespace :my do
    resources :recipes, only: %i(new create edit destroy update)
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
