Rails.application.routes.draw do
  get 'sessions/new'
  get 'sessions/create'
  get root 'static_pages#home'
  get '/about' => 'static_pages#about'
  get '/help'  => 'static_pages#help'

  get '/signup' => 'users#new'
  post '/signup' => 'users#create'

  resources :users

  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  delete '/logout' => 'sessions#destroy'

end
