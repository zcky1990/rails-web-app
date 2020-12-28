class User::HomeController < ApplicationController
    def index
        @token = get_token()
        @data = {'message': "test data message"}
    end
end
