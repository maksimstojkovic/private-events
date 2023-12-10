Rails.application.routes.draw do
  root to: "events#index"
  
  devise_for :users
  get "users/:id", to: "users#show", as: "profile"
  
  resources :events
  resources :event_attendees, path: "attend", as: "attend"

  get "up" => "rails/health#show", as: :rails_health_check
end
