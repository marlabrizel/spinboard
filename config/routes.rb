Rails.application.routes.draw do
  root to: 'welcome#index'

  resources :users, only: [:new, :create, :show]

  namespace :api do
    namespace :v1 do
      resources :links, only: [:update]
    end
  end

  resources :links, only: [:index, :create, :edit, :update] do
    member do
      put 'mark_read'
      put 'mark_unread'
    end
  end

  get '/s/:slug', to: 'short_urls#show', as: :short_url

  get '/logout', to: 'sessions#destroy'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
end
