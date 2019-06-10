# frozen_string_literal: true

Rails.application.routes.draw do
  get root 'static_pages#home'
  %w[about contact popular category test_login].each do |path|
    get path => "static_pages##{path}"
  end

  get '/signup' => 'users#new'
  post '/signup' => 'users#create'
  resources :users, except: %i[new create] do
    resource :likes, only: :show
  end

  resources :phrases do
    resources :comments, only: :create
    post 'likes' => 'likes#create'
    delete 'likes' => 'likes#destroy'
  end

  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  delete '/logout' => 'sessions#destroy'
end
