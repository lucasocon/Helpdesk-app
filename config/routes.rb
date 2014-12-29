Rails.application.routes.draw do

  devise_for :users

  get  '/signup', to: "auth/accounts#new"
  post '/signup', to: "auth/accounts#create"
  get '/login', to:   "welcome#login"

  scope('/:company_slug') do
    get '/', to: 'company/dashboard#index', as: :dashboard
    get '/products', to: 'company/products#index', as: :products_all

    resources  :products, module: :company , only: [:new, :create]

    get '/new_member', to: 'company/registrations#new_member', as: :new_member

  end

  root to: 'welcome#index'
end
