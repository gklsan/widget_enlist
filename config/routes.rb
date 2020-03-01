Rails.application.routes.draw do
  root 'widgets#index'
  resources :widgets, :users
  post 'login', to: 'users#login'
  post 'logout', to: 'users#logout'
  post 'change_password', to: 'users#change_password'
  post 'reset_password', to: 'users#reset_password'
end
