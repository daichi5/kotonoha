Rails.application.routes.draw do
  get root 'static_pages#home'
  get 'about' => 'static_pages#about'
  get 'help'  => 'static_pages#help'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
