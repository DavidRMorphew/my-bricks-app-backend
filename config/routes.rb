Rails.application.routes.draw do
  
  resources :users

  get '/logged_in', to: 'auth#logged_in'
  post '/login', to: 'auth#create'
  delete '/logout', to: 'auth#destroy'

  # update these
  get "/lego_sets/owned", to: "lego_sets#owned_sets", as: "owned_sets"
  get "/lego_sets/potential_builds/:strictParam", to: "lego_sets#potential_builds", as: "potential_builds"

  # remove update from lego_sets
  resources :lego_sets, only: [:index, :update] do
    resources :set_part_specs, only: [:index]
    resources :parts, only: [:index]
  end
  
  resources :owned_sets, only: [:index, :create, :destroy]

end
