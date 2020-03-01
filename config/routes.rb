Rails.application.routes.draw do
  root 'widgets#index'
  resources :widgets, :users
  post 'login', to: 'users#login'
  post 'logout', to: 'users#logout'
end
