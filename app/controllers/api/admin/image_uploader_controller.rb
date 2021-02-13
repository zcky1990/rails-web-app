class Api::Admin::ImageUploaderController < Api::Admin::ApplicationController
  before_action :authorize_request
  respond_to :json

  def initialize
    super
  end

  def upload
    imageFile = params[:image]
    fileName = imageFile.original_filename
    folder = "article"
        imageResponse = Cloudinary::Uploader.upload_large(imageFile.open, :public_id => fileName, :folder => folder, :overwrite => true)
        if imageResponse['secure_url'].present?
            data = {
                secure_url: imageResponse['secure_url']
            }
            response = Api::SuccessObjectResult.new(data: data, message: "success upload image")
        else
          response = Api::ErrorResult.new(error_code: 500, error_title: "Error get upload image", error_message: "Error get upload image")
        end
    render :json => response, :status => 200
  end
end
