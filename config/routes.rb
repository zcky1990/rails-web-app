Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  devise_for :user, only: [], controllers: { omniauth_callbacks: "omniauth_callbacks" }
  # devise_for :user, class_name: 'User',
  #   :controllers => {
  #     :sessions=> 'api/v1/sessions',
  #     :registrations=> 'api/v1/registrations'
  # }, module: :devise

  namespace :admin do
    resource :index, only: [], :path => "/" do
      get "/dashboard", to: "index#index", as: "index"
    end

    resource :login, only: [:index] do
      collection do
        get "/", to: "login#index", as: "login"
      end
    end

    resource :web_meta_data, only: [] do
      collection do
        get "/", to: "web_meta_data#index", as: "web_meta_data"
      end
    end

    resource :user, only: [] do
      collection do
        get "/", to: "user#index", as: "user"
      end
    end
  end

  namespace :user do
    resource :home, only: [], :path => "/" do
      get "/", to: "home#index", as: "index"
    end
  end

  namespace :api do
    namespace :admin do
      resource :sessions, only: [] do
        post "/admin_login", to: "sessions#login", as: "login"
        post "/admin_logout", to: "sessions#logout", as: "logout"
      end

      resources :web_meta_data, only: [] do
        post "upload_image", action: :upload_image, on: :collection
        post "create_web_meta_data", action: :create_web_meta_data, on: :collection
        put "update_web_meta_data", action: :update_web_meta_data, on: :collection
      end

      resources :user, only: [] do
        get "get_admin_list", action: :get_user_admin_list, on: :collection
        post "add_new_admin", action: :add_user_admin, on: :collection
        put "update_admin", action: :update_user_admin, on: :collection
        delete "remove_admin", action: :remove_user_admin, on: :collection

        get "get_user_list", action: :get_user_list, on: :collection
        post "add_new_user", action: :add_new_user, on: :collection
        put "update_user", action: :update_user, on: :collection
        delete "remove_user", action: :remove_user, on: :collection
      end
    end

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

  root "user/home#index"
end
