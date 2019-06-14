# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: 'users/sessions', registrations: 'users/registrations' }
  get root 'static_pages#home'

  %w[about contact popular category test_login].each do |path|
    get path => "static_pages##{path}"
  end

  resources :users, only: %i[index show] do
    resource :likes, only: :show
  end

  resources :phrases do
    resources :comments, only: :create
    post 'likes' => 'likes#create'
    delete 'likes' => 'likes#destroy'
  end

end
