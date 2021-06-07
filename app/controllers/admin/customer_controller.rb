class Admin::CustomerController < Admin::ApplicationController
  before_action :is_sign_in

  def initialize
    super
    @service = Admin::CustomerService.new
  end

  def customer_list
    @token = get_token(current_user)
    if params[:typeSearch].present?
      @data = @service.search_customer(params)
    else
      page = get_page(params)
      @data = @service.get_customer_list(page)
    end
  end

  def add_customer
    result = @service.add_customer(params, current_user)
    redirect_to customer_list_admin_customer_url, :flash => result
  end

  def update_customer
    result = @service.update_customer(params, current_user)
    redirect_to customer_list_admin_customer_url, :flash => result
  end

  def remove_customer
    result = @service.delete_customer(params, current_user)
    redirect_to customer_list_admin_customer_url, :flash => result
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
