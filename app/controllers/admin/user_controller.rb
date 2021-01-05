class Admin::UserController < Admin::ApplicationController
  # before_action :is_sign_in

  def initialize
    super
    @service = Admin::UserService.new
  end

  def index
    @meta_tag = get_default_web_meta_data()
    @token = get_token(current_user)

    if !params[:type].present?
      type = "admin"
    else
      type = params[:type]
    end

    if !params[:page].present?
      page = 1
    else
      if params[:page] == 0
        page = 1
      else
        page = params[:page]
      end
    end
    @data = @service.get_admin_list(type, page)
  end
end
