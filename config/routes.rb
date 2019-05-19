Rails.application.routes.draw do
  get root 'static_pages#home'
  get '/about' => 'static_pages#about'
  get '/contact'  => 'static_pages#contact'
  get '/test_login'  => 'static_pages#test_login'

  get '/signup' => 'users#new'
  post '/signup' => 'users#create'
  resources :users, except: [:new, :create] do
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
