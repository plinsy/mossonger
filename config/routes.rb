Rails.application.routes.draw do
  default_url_options host: "127.0.0.1:3000"
  resources :readings
  resources :conversations do
    delete '/invitations', to: "invitations#destroy_all", as: "destroy_all_invitations"
    resources :invitations
    resources :nicknames
    resources :messages
  end
  resources :condemneds
  resources :blacklists
  resources :aliens
  resources :spaces
  resources :secrets
  resources :hiding_places
  resources :trashes
  resources :dropboxes
  get '/settings', to: 'chat_settings#edit', as: 'settings'
  resources :chat_settings
  resources :chats, only: %[index]
  resources :friendships
  devise_for :users, controllers: {
    sessions: "users/sessions",
    registrations: "users/registrations",
    confirmations: "users/confirmations",
    unlocks: "users/unlocks",
    passwords: "users/passwords"
  }
  # pages
  get 'pages/rooms'
  get 'pages/features'
  get 'pages/privacy'
  get 'pages/for_developers'
  root to: 'pages#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
