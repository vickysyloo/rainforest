Rails.application.routes.draw do

root 'products#index'

resources :products
resources :users, only: [:new, :create]

end
