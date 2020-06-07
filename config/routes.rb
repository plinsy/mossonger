Rails.application.routes.draw do
  get 'users/index'
  default_url_options host: "127.0.0.1:3000"
  resources :readings
  resources :messages, only: %i(create)
  get '/new', to: 'messages#new', as: 'new_message'
  post '/conversations/search', to: 'conversations#search', as: 'conversations_search'
  resources :conversations do
    get '/reply/:messageable_type/:messageable_id', to: 'messages#reply', as: 'reply'
    delete '/invitations', to: "invitations#destroy_all", as: "destroy_all_invitations"
    resources :invitations
    resources :nicknames
    resources :messages
  end
  resources :condemneds
  resources :blacklists
  resources :aliens
  get '/mute/:muteable_type/:muteable_id', to: "spaces#mute", as: "mute"
  resources :spaces
  resources :secrets
  resources :hiding_places
  resources :trashes
  get '/drop/:dropable_type/:dropable_id', to: "dropboxes#drop", as: "drop"
  resources :dropboxes do
  end
  get '/settings', to: 'chat_settings#edit', as: 'settings'
  resources :chat_settings
  resources :chats, only: %i(index)
  resources :friendships
  resources :users, only: %i(index)
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
