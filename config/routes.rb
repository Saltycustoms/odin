Rails.application.routes.draw do
  resources :products, only: [:show]
  get "/products/:id/price_ranges", to: "products#price_ranges"
  get "/attachments/:id", to: "attachments#download", as: "attachment"
  namespace :api do
    namespace :v1 do
      resources :add_ons
      resources :approvals
      resources :deals
      resources :job_requests
      resources :quotations
      resources :deadlines
      resources :organizations
      resources :pics
      resources :print_details
      resources :quotation_lines
      resources :properties
      resources :simple_configurator
    end
  end
  get "/states", to: "packing_lists#states"
  resources :print_details
  resources :deals do
    collection do
      get "my_deals"
    end
    resource :quotations
    resources :job_requests do
      member do
        get "duplicate"
        post "create_duplicate"
      end
    end
    resources :deadlines
    resources :approvals
    resources :packing_lists
    resources :transactions
    resources :conditions
  end
  get '/products/:product_id/colors/new', to: "products#new_color", as: "new_color"
  post '/products/:product_id/colors', to: "products#create_color", as: "colors"

  resources :departments do
    resources :deals
  end
  resources :pics do
    resources :deals
  end
  devise_for :users, controllers: { :omniauth_callbacks => "users/omniauth_callbacks", :sessions=> 'users/sessions' }
  resources :organizations do
    resources :departments
  end
  resources :deadlines, only: [:show]
  resources :packing_lists, only: [:show]
  get '/quotations/:id', to: "quotations#show_quotation"
  resources :gateways
  resources :welcome
  resources :notifications
  resources :samples
  resources :histories
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'welcome#index'

end
