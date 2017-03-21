Rails.application.routes.draw do
  resources :attachments
  namespace :api do
    namespace :v1 do
      resource :braintree
      resource :blank
      resources :blanks
      resources :orders do
        collection do
          patch 'bulk_update'
        end
      end
      jsonapi_resources :orders
      jsonapi_resources :attachments
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
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
