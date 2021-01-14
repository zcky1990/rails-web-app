class Admin::UserAdminController < Admin::ApplicationController
  # before_action :is_sign_in

  def initialize
    super
    @service = Admin::UserAdminService.new
  end

  def index
    @notif = get_notif(flash)
    @meta_tag = get_default_web_meta_data()
    @token = get_token(current_user)
    type = get_type(params)
    page = get_page(params)
    @data = @service.get_user_list(type, page)
  end

  def search_user
    @data = @service.search_user(params)
    @meta_tag = get_default_web_meta_data()
  end

  def add_user
    result = @service.add_user(params)
    redirect_to user_admin_user_admin_url, :flash => result
  end

  def update_user
    result = @service.update_user(params)
    redirect_to user_admin_user_admin_url, :flash => result
  end

  def remove_user
    result = @service.remove_user(params)
    redirect_to user_admin_user_admin_url, :flash => result
  end

  private

  def get_type(params)
    if !params[:type].present?
      type = "admin"
    else
      type = params[:type]
    end
  end

  def get_page(params)
    if !params[:page].present?
      page = 1
    else
      if params[:page] == 0
        page = 1
      else
        page = params[:page].to_i
      end
    end
  end
end
