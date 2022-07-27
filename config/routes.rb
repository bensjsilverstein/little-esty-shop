Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/', to: 'application#welcome'

#feat/merchant_invoice_index
  resources :merchants do
    get '/invoices', to: 'merchant_invoices#index'
    get '/invoices/:invoice_id', to: 'merchant_invoices#show'
  end
  
  get '/merchants/:id/items/new', to: 'merchant_items#new'
  get "/merchants/:id/items", to: "merchant_items#index"
  post 'merchants/:id/items', to: 'merchant_items#create'
  
  get '/merchants/:id/items/:item_id', to: 'merchant_items#show'
  
  get '/merchants/:merchant_id/dashboard', to: 'merchant_dashboards#show'

end
