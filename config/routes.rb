Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      namespace :merchants do
        get 'find/', to: 'find#show'
        get 'find_all/', to: 'find#index'
        get 'random/', to: 'random#show'
        get 'most_revenue/', to: 'most_revenue#index'
        get 'most_items/', to: 'most_items#index'
        get 'revenue/', to: 'revenue#index'
        get ':id/revenue/', to: 'revenue#show'
        get ':id/favorite_customer/', to: 'favorite_customer#show'
        get ':id/items', to: 'items#index'
        get ':id/invoices', to: 'invoices#index'
      end

      namespace :invoices do
        get 'find/', to: 'find#show'
        get 'find_all/', to: 'find#index'
        get 'random/', to: 'random#show'
        get ':id/transactions/', to: 'transactions#index'
        get ':id/invoice_items/', to: 'invoice_items#index'
        get ':id/items/', to: 'items#index'
        get ':id/customer/', to: 'customer#show'
        get ':id/merchant/', to: 'merchant#show'
      end

      namespace :invoice_items do
        get 'find/', to: 'find#show'
        get 'find_all/', to: 'find#index'
        get 'random/', to: 'random#show'
        get ':id/invoice/', to: 'invoice#show'
        get ':id/item/', to: 'item#show'
      end

      resources :merchants, only: [:index, :show]
      resources :invoices, only: [:index, :show]
      resources :invoice_items, only: [:index, :show]
    end
  end
end
