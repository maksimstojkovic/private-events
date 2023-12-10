Rails.application.routes.draw do
  root to: "events#index"
  
  devise_for :users
  get "users/:id", to: "users#show", as: "profile"
  
  resources :events
  resources :event_attendees, path: "events/:id/attend", param: :attend_id, as: "attend", only: [ :new, :create, :destroy ]

  get "up" => "rails/health#show", as: :rails_health_check
end
