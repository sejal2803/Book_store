Rails.application.routes.draw do
  resources :books
  # get '/books/:id', to: 'books#show'
end
