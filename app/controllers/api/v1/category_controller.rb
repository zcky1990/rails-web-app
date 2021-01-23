class Api::V1::CategoryController < Api::V1::ApplicationController
  before_action :authorize_request, except: :login
  respond_to :json

  def initialize
    super
    @service = Api::V1::CategoryService.new
  end

  def get_category_list
    response = @service.search_category(params)
    render :json => response, :status => 200
  end
end
