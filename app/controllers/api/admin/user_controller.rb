class Api::Admin::UserController < Api::Admin::ApplicationController
  # before_action :authorize_request
  respond_to :json

  def initialize
    @service = Api::Admin::UserService.new
  end

  def get_user_admin_list
    result = @service.get_admin_list(params)
    render :json => result, :status => 200
  end

  def add_user_admin
    result = @service.add_admin(params)
    render :json => result, :status => 200
  end

  def update_user_admin
    result = @service.update_admin(params)
    render :json => result, :status => 200
  end

  def remove_user_admin
    result = @service.remove_admin(params)
    render :json => result, :status => 200
  end

  def get_user_list
    result = @service.get_user_list(params)
    render :json => result, :status => 200
  end

  def add_user
    result = @service.add_user(params)
    render :json => result, :status => 200
  end

  def update_user
    result = @service.update_user(params)
    render :json => result, :status => 200
  end

  def remove_user
    result = @service.remove_user(params)
    render :json => result, :status => 200
  end
end
