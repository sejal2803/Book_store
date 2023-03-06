Rails.application.routes.draw do
  resources :books
  resources :admins
  post   '/login',   to: 'sessions#create'
end
