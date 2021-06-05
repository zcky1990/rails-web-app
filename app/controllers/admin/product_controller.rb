class Admin::ProductController < Admin::ApplicationController
  before_action :is_sign_in

  def initialize
    super
    @category_service = Admin::CategoryService.new
    @product_service = Admin::ProductService.new
  end

  def product_list
    @token = get_token(current_user)
    if params[:typeSearch].present?
      @data = @product_service.search_product(params)
    else
      page = get_page(params)
      @data = @product_service.get_product_list(page)
    end
  end

  def category
    @token = get_token(current_user)
    if params[:typeSearch].present?
      @data = @category_service.search_category(params)
    else
      page = get_page(params)
      @data = @category_service.get_category_list(page)
    end
  end

  def add_category
    result = @category_service.add_category(params, current_user)
    redirect_to product_category_admin_product_url, :flash => result
  end

  def update_category
    result = @category_service.update_category(params, current_user)
    redirect_to product_category_admin_product_url, :flash => result
  end

  def remove_category
    result = @category_service.delete_category(params, current_user)
    redirect_to product_category_admin_product_url, :flash => result
  end

  def get_category_list
    response = @category_service.get_category_dropdown_list
    render :json => response, :status => 200
  end

  def add_product
    result = @product_service.add_product(params, current_user)
    redirect_to product_list_admin_product_url, :flash => result
  end

  def update_product
    result = @product_service.update_product(params, current_user)
    redirect_to product_list_admin_product_url, :flash => result
  end

  def remove_product
    result = @product_service.delete_product(params, current_user)
    redirect_to product_list_admin_product_url, :flash => result
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
