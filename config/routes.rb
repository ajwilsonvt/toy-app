Rails.application.routes.draw do
  resources :microposts
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # This sets up the following controller#action
  # /users        => users#index
  # /users/1      => users#show
  # /users/new    => users#new
  # /users/1/edit => users#edit
  resources :users
  
  root 'users#index' # application#hello
end
