Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  devise_for :user, only: [], controllers: { omniauth_callbacks: "omniauth_callbacks" }
  # devise_for :user, class_name: 'User',
  #   :controllers => {
  #     :sessions=> 'api/v1/sessions',
  #     :registrations=> 'api/v1/registrations'
  # }, module: :devise

  namespace :admin do
    resource :index, only: [], :path => '/'  do
      get '/dashboard', to: 'index#index', as: 'index'
    end

    resource :web_meta, only: [:web_meta], :path => '/'  do
      get '/web_meta', to: 'web_meta#index', as: 'index'
    end

    resource :user_admin, only: [:web_meta], :path => '/'  do
      get '/user_admin', to: 'user_admin#index', as: 'index'
    end

    resource :login, only: [:index] do
      collection do
        get '/', to: 'login#login', as: 'login'
      end
    end
  end
  
  namespace :api do
    namespace :v1 do
      resource :sessions, only: [] do
        post "/login", to: "sessions#login", as: "login"
        post "/logout", to: "sessions#logout", as: "logout"
        post "/google_login", to: "sessions#google_login", as: "google_login"
        post "/facebook_login", to: "sessions#facebook_login", as: "facebook_login"
        post "/twitter_login", to: "sessions#twitter_login", as: "twitter_login"
      end

      resource :registrations, only: [] do
        post "/sign-up", to: "registrations#sign_up", as: "sign-up"
      end

      resource :jwt, only: [] do
        get "/generate_jwt", to: "jwt#generate_jwt", as: "generate_jwt"
      end
    end
  end

  resources :home, only: [], :path => "/" do
    get "/", to: "home#index", as: "index"
  end

  root "home#index"
end
