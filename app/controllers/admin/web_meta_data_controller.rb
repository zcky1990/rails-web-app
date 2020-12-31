class Admin::WebMetaDataController < Admin::ApplicationController
  before_action :is_sign_in,  :get_default_web_meta_data
  
  def initialize
    super
    @service = Admin::WebMetaDataService.new
  end

  def index
    @token = get_token(current_user)
    @data = @service.get_web_meta_data()
  end  

end
