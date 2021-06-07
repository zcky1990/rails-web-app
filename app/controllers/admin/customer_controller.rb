class Admin::CustomerController < Admin::ApplicationController
  before_action :is_sign_in

  def initialize
    super
    @service = Admin::CategoryService.new
  end

  def customer_list
    @token = get_token(current_user)
    if params[:typeSearch].present?
      @data = @service.search_category(params)
    else
      page = get_page(params)
      @data = @service.get_category_list(page)
    end
  end

  def search_category
    @data = @service.search_category(params)
    @token = get_token(current_user)
    @meta_tag = get_default_web_meta_data()
  end

  def add_category
    result = @service.add_category(params, current_user)
    redirect_to user_admin_category_url, :flash => result
  end

  def update_category
    result = @service.update_category(params, current_user)
    redirect_to user_admin_category_url, :flash => result
  end

  def remove_category
    result = @service.delete_category(params, current_user)
    redirect_to user_admin_category_url, :flash => result
  end

  private

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
