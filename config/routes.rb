Rails.application.routes.draw do
  resources :orders
  resources :products

  get 'stores/:id/products_sales', to: 'stores#products_sales', as: 'store_products_sales'
  get 'stores/:id/orders', to: 'stores#orders', as: 'store_orders'

  resources :stores do
    member do
      get 'orders', to: 'stores#orders'
    end
    collection do
      get 'top_stores', to: 'stores#top_stores'
    end
  end

  root "home#index"
end