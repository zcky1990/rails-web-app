class Admin::WebMetaDataController < ApplicationController
  before_action :is_sign_in
  
  def initialize
    super
    @service = Admin::WebMetaDataService.new
  end

  def index
    @token = get_token(current_user)
    @data = @service.get_web_meta_data()
  end  

  private
  def is_sign_in
      if !user_signed_in?
        redirect_to "/admin/login"
      end
  end
end
