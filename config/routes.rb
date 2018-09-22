Rails.application.routes.draw do
  namespace :api do
    post "/user", to: "user#create", as: 'user_create'
    post '/login', to: "login#create", as: 'login'
    put 'user/:user_id', to: "user#update", as: 'user_update'
    post "/players", to: "players#create", as: 'players_create'
    get "/players", to: "players#index", as: 'players_listing'
    delete "/players/:player_id", to: "players#destroy", as: 'players_delete'
  end
end
