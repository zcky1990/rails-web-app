class HomeController < ApplicationController
    def index
        @data = {'message': "test data message"}
    end
end
