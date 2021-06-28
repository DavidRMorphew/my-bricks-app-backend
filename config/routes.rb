Rails.application.routes.draw do
  get 'parts/index'
  get 'set_part_specs/index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :lego_sets, only: [:index, :update] do
    resources :set_part_specs, only: [:index]
    resources :parts, only: [:index]
  end

  get "/lego_sets/owned", to: "lego_sets#owned_sets", as: "owned_sets"
end
