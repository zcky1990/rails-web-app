class Admin::IndexController < ApplicationController
  def index
    @token = get_token(current_user)
  end  
  
end
