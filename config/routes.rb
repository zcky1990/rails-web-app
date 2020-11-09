Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  devise_for :user, only: []
  # devise_for :user, class_name: 'User', 
  #   :controllers => { 
  #     :sessions=> 'api/v1/sessions', 
  #     :registrations=> 'api/v1/registrations'
  # }, module: :devise

  namespace :api do
    namespace :v1 do
      
        resource :sessions, only:[] do
          post '/login', to: 'sessions#login', as: 'login'
          post '/logout', to: 'sessions#logout', as: 'logout'
        end

        resource :registrations, only:[] do
          post '/sign-up', to: 'registrations#sign_up', as: 'sign-up'
        end
          
      resource :jwt, only: [] do
        get '/generate_jwt', to: 'jwt#generate_jwt', as: 'generate_jwt'
      end  
    end
  end

  resources :home, only: [], :path => '/'  do
    get '/', to: 'home#index', as: 'index'
  end

  root 'home#index'
end
