Rails.application.routes.draw do

  namespace :api do
    resources :players, path: :player
  end
  
  get "up" => "rails/health#show", as: :rails_health_check
end
