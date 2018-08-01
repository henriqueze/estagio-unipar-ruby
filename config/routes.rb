Rails.application.routes.draw do

  get 'admin', to: 'backoffice/dashboard#index'

  namespace :backoffice do
    resources :categories, except: [:show, :destroy]
    resources :people, except: [ :destroy]
    resources :products, except: [:destroy]
    resources :payment_types, except: [:destroy]
    resources :sales, except: [:destroy]
    resources :budgets, except: [:destroy]
    resources :purchases, except: [:destroy]
    resources :accounts_receivables, except: [:destroy]

    get 'categories/index'
    get 'people/index'
    get 'products/index'
    get 'payment_types/index'
    get 'sales/index'
    get 'budgets/index'
    get 'purchase/index'
    get 'accounts_receivables/index'
    get 'dashboard', to: 'dashboard#index'
  end

  namespace :site do
    get 'home', to: 'home#index'
  end
  resources :accounts_payables

  devise_for :system_users
  devise_for :master_users

  get 'home/index'
  root 'site/home#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
