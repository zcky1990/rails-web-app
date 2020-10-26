class HomeController < ActionController::Base

    def index
        @data = {'message': "test data message"}
    end
end
