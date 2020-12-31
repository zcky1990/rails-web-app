class Admin::IndexController < Admin::ApplicationController
  before_action :is_sign_in
  
  def index
    @token = get_token(current_user)
  end  
  
end
