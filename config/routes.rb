Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :deals
      resources :job_requests
    end
  end
  resources :print_details
  resources :job_requests
  resources :deals do
    resources :job_requests
  end
  resources :departments, only: [:index] do
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
