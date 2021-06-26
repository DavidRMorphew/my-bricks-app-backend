Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :lego_sets, only: [:index, :update]

  get "/lego_sets/owned", to: "lego_sets#owned_sets", as: "owned_sets"
end
