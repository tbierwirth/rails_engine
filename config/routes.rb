Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      namespace :merchants do
        get 'find/', to: 'find#show'
        get 'find_all/', to: 'find#index'
        get ':id/items', to: 'items#index'
        get ':id/invoices', to: 'invoices#index'
      end

      namespace :invoices do
        get 'find/', to: 'find#show'
      end

      resources :merchants, only: [:index, :show]
      resources :invoices, only: [:index, :show]
    end
  end
end
