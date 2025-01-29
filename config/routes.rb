Rails.application.routes.draw do
  resources :tracks
  resources :albums
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "albums#index"

  # Defines the sign in routes
  get "sign_in" => "auth#sign_in", as: :sign_in
  post "sign_in" => "auth#sign_in_post", as: :sign_in_post

  # Defines the sign up routes
  get "sign_up" => "auth#sign_up", as: :sign_up
  post "sign_up" => "auth#sign_up_post", as: :sign_up_post

  # Defines the sign out routes
  delete "sign_out" => "auth#sign_out", as: :sign_out
end
