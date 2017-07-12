Rails.application.routes.draw do
  resources :products, only: [:show]
  get "/products/:id/price_ranges", to: "products#price_ranges"
  namespace :api do
    namespace :v1 do
      resources :deals
      resources :job_requests
    end
  end
  resources :print_details
  resources :deals do
    resource :quotations
    resources :job_requests
    resources :deadlines
  end
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
  resources :welcome
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'welcome#index'

end
