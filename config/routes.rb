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

    resource :product, only: [] do
      collection do
        get "/", to: "product#category", as: "product_index"
        get "/product-category", to: "product#category", as: "product_category"
        get "/product-list", to: "product#product_list", as: "product_list"
        get "/product-price-type", to: "product#price_type", as: "price_type"
        post "/add-category", to: "product#add_category", as: "add_new_category_data"
        post "/remove-product-category", to: "product#remove_category", as: "remove_category_data"
        post "/update-product-category", to: "product#update_category", as: "update_category_data"
        get "/get-category-list-dropdown", to: "product#get_category_list", as: "get_category_list"
        post "/add-product-list", to: "product#add_product", as: "add_new_product_data"
        post "/update-product-list", to: "product#update_product", as: "update_product_data"
        post "/remove-product-list", to: "product#remove_product", as: "remove_product_data"
        post "/add-price-type-list", to: "product#add_price_type", as: "add_new_price_type"
        post "/update-price-type-list", to: "product#update_price_type", as: "update_price_type_data"
        post "/remove-price-type-list", to: "product#remove_price_type", as: "remove_price_type_data"
        get "/get-price-type-list-dropdown", to: "product#get_price_type_list", as: "get_price_type_dropdown_list"
      end
    end

    resource :customer, only: [] do
      collection do
        get "/", to: "customer#customer_list", as: "customer_list"
        post "/add-customer", to: "customer#add_customer", as: "add_new_customer"
        post "/remove-customer", to: "customer#remove_customer", as: "remove_customer"
        post "/update-customer", to: "customer#update_customer", as: "update_customer"
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

    resource :article, only: [] do
      collection do
        get "/", to: "article#index", as: "user"
        post "/add", to: "article#add_article", as: "add_new_article_data"
        post "/remove", to: "article#remove_article", as: "remove_article_data"
        post "/update", to: "article#update_article", as: "update_article_data"
        get "/search", to: "article#search_article", as: "search_article_data"
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

      resource :image_uploader, only: [] do
        post "/upload", to: "image_uploader#upload", as: "upload_image"
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
