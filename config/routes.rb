Rails.application.routes.draw do

  namespace :api do
    resources :players, path: :player
    post 'team/process', to: 'team#player_process'
  end
  
  get "up" => "rails/health#show", as: :rails_health_check
end
