class User::HomeController < ApplicationController
    def initialize
        super
        @product_service = User::ProductService.new
      end

    def index
        @token = get_token()
       
    end

    def online_cashier_app
        @token = get_token()
        @data = @product_service.get_all_product_list()
    end
end
