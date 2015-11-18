Rails.application.routes.draw do
  root to: 'welcome#index'
  resources :users, only: [:new, :create, :show]
  resources :links, only: [:index]
  get '/logout', to: 'sessions#destroy'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
end
