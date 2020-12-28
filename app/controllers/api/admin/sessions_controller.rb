class Api::Admin::SessionsController < Api::Admin::ApplicationController
  before_action :authorize_request, except: :login
  respond_to :json

  def initialize
    super
    @service = Api::Admin::SessionsService.new
  end

  def login
    is_user_sign_in = user_signed_in?
    response = @service.sign_in_user(params, is_user_sign_in, method(:login_user_callback))
    render :json => response, :status => 200
  end

  def logout
    if @current_user.present?
      response = @service.sign_out_user(@current_user, method(:logout_user_callback))
      render :json => response, :status => 200
    else
      response = @service.set_user_result_json(FAILED, nil, ERROR_FAILED_LOGOUT)
      render :json => response, :status => 200
    end
  end

  def login_user_callback(user)
    sign_in(user)
  end

  def logout_user_callback(user)
    sign_out(user)
  end
end
