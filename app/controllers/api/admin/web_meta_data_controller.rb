class Api::Admin::WebMetaDataController < Api::Admin::ApplicationController
  before_action :authorize_request
  respond_to :json

  def initialize
    @service = Api::Admin::WebMetaDataService.new
  end

  def create_web_meta_data
    result = @service.web_meta_data(params)
    render :json=> result, :status=>200
  end

  def update_web_meta_data
    result = @service.web_meta_data(params)
    render :json=> result, :status=>200
  end

  def upload_image
    result = @service.upload_image(params[:imagefile], params[:folder])
    render :json=> result, :status=>200
  end
end
