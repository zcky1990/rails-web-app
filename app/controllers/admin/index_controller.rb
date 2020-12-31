class Admin::IndexController < Admin::ApplicationController
  before_action :is_sign_in, :get_default_web_meta_data
  
  def index
    @token = get_token(current_user)
  end  
  
end
