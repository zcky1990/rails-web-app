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
      get "/", to: "index#index", as: "index"
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

    resource :user_admin, only: [] do
      collection do
        get "/", to: "user_admin#index", as: "user"
        post "/add", to: "user_admin#add_user", as: "add_new_user_data"
        post "/remove", to: "user_admin#remove_user", as: "remove_user_data"
        post "/update", to: "user_admin#update_user", as: "update_user_data"
        get "/search", to: "user_admin#search_user", as: "search_user_data"
      end
    end

    resource :user, only: [] do
      collection do
        get "/", to: "user#index", as: "user"
        post "/add", to: "user#add_user", as: "add_new_user_data"
        post "/remove", to: "user#remove_user", as: "remove_user_data"
        post "/update", to: "user#update_user", as: "update_user_data"
        get "/search", to: "user#search_user", as: "search_user_data"
      end
    end

    resource :category, only: [] do
      collection do
        get "/", to: "category#index", as: "user"
        post "/add", to: "category#add_category", as: "add_new_category_data"
        post "/remove", to: "category#remove_category", as: "remove_category_data"
        post "/update", to: "category#update_category", as: "update_category_data"
        get "/search", to: "category#search_category", as: "search_category_data"
      end
    end

    resource :article, only: [] do
      collection do
        get "/", to: "article#index", as: "user"
        post "/add", to: "article#add_category", as: "add_new_article_data"
        post "/remove", to: "article#remove_category", as: "remove_article_data"
        post "/update", to: "article#update_category", as: "update_article_data"
        get "/search", to: "article#search_category", as: "search_article_data"
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

      resource :category, only: [] do
        post "/get_category_list", to: "category#get_category_list", as: "get_category_list"
      end

      resource :jwt, only: [] do
        get "/generate_jwt", to: "jwt#generate_jwt", as: "generate_jwt"
      end
    end
  end

  root "user/home#index"
end
