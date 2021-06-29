Rails.application.routes.draw do
  
  get "/lego_sets/owned", to: "lego_sets#owned_sets", as: "owned_sets"
  get "/lego_sets/potential_builds", to: "lego_sets#potential_builds", as: "potential_builds"

  resources :lego_sets, only: [:index, :update] do
    resources :set_part_specs, only: [:index]
    resources :parts, only: [:index]
  end

end
