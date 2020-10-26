Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :home, only: [], :path => '/'  do
    get '/', to: 'home#index', as: 'index'
  end

  root 'home#index'
end
