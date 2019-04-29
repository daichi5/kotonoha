Rails.application.routes.draw do
  get root 'static_pages#home'
  get '/about' => 'static_pages#about'
  get '/help'  => 'static_pages#help'

  get '/signup' => 'users#new'
  post '/signup' => 'users#create'
  resources :users, except: [:new, :create] do
      resource :likes, only: [:show]
  end

  resources :phrases do
    resources :comments, only: :create
  end

  post '/phrases/:phrase_id/likes' => 'likes#create', as: :like
  delete '/phrases/:phrase_id/likes' => 'likes#destroy'

  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  delete '/logout' => 'sessions#destroy'


end
