class Admin::WebMetaDataController < ApplicationController
  
  def initialize
    super
    @service = Admin::WebMetaDataService.new
  end

  def index
    @data = @service.get_web_meta_data()
  end  
end
