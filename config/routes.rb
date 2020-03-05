Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :items, :shops, :users, :orders

  post "users/login", to: 'users#login'

  get 'homepage', to: 'homepage#index'
  get 'profile', to: 'profile#index'
  post 'profile', to: 'profile#update'
  get 'signin', to: 'signin#index'
  get 'signup', to: 'signup#index'


  root to: 'homepage#index'

end
