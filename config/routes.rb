Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  root "dashboard#index"

  get "/auth/auth0/callback" => "auth0#callback"
  get "/auth/failure" => "auth0#failure"
  get "/auth/logout" => "auth0#logout"

  resources :links, param: :shortcode, except: %i[destroy]
  resources :views, only: %i[index]

  constraints shortcode: /[A-Za-z0-9]{4}/ do
    get "/:shortcode", to: "redirect#redirect"
    get "/p/:shortcode", to: "redirect#show"
  end
end
