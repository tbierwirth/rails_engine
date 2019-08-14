Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      get 'merchants/find/', to: 'merchants_find#show'
      get 'merchants/find_all/', to: 'merchants_find#index'
      resources :merchants, only: [:index, :show]
    end
  end
end
