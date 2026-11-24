Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check
  root "entries#index"
  resources :entries, only: [:index, :create]
  get "flaskepost", to: "flaskepost#new"
  post "flaskepost", to: "flaskepost#create"
end
