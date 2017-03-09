Rails.application.routes.draw do
  resources :designs
  resources :blanks
  resources :addresses
  resources :shipping_zones
  resources :shipping_zone_locations
  resources :shipping_methods
  resources :shipments
  resources :statements
  resources :orders
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
