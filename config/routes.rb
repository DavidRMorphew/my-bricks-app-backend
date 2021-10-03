Rails.application.routes.draw do
  
  resources :users

  get '/login', to: 'auth#create'
  # update these
  get "/lego_sets/owned", to: "lego_sets#owned_sets", as: "owned_sets"
  get "/lego_sets/potential_builds/:strictParam", to: "lego_sets#potential_builds", as: "potential_builds"

  resources :lego_sets, only: [:index, :update] do
    resources :set_part_specs, only: [:index]
    resources :parts, only: [:index]
  end

end
