class Admin::WebMetaDataController < Admin::ApplicationController
  before_action :is_sign_in
  
  def initialize
    super
    @service = Admin::WebMetaDataService.new
  end

  def index
    @meta_tag = get_default_web_meta_data()
    @token = get_token(current_user)
    @data = @service.get_web_meta_data()
  end  

end
