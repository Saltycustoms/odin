Rails.application.routes.draw do
  resources :attachments
  namespace :api do
    namespace :v1 do
      resource :braintree
      resource :blank
      resources :orders do
        collection do
          patch 'bulk_update'
        end
      end
      jsonapi_resources :blanks
      jsonapi_resources :orders
      jsonapi_resources :order_lines
      jsonapi_resources :addresses
      jsonapi_resources :shipping_addresses
      jsonapi_resources :billing_addresses
      jsonapi_resources :billing_addresses
      jsonapi_resources :surfaces
      resources :attachments
      # jsonapi_resources :attachments
    end
  end
  resources :designs
  resources :blanks
  resources :addresses
  resources :shipping_zones
  resources :shipping_zone_locations
  resources :shipping_methods
  resources :shipments
  resources :statements
  resources :orders
  get '/socket.io' => 'statements#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
