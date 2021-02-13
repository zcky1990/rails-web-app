class Admin::ArticleController < Admin::ApplicationController
  before_action :is_sign_in

  def initialize
    super
    @service = Admin::ArticleService.new
  end

  def index
    @meta_tag = get_default_web_meta_data()
    @token = get_token(current_user)
    page = get_page(params)
    @data = @service.get_category_list(page)
  end

  def search_article
    @data = @service.search_article(params)
    @token = get_token(current_user)
    @meta_tag = get_default_web_meta_data()
  end

  def add_article
    result = @service.add_article(params, current_user)
    redirect_to user_admin_category_url, :flash => result
  end

  def update_article
    result = @service.update_article(params, current_user)
    redirect_to user_admin_category_url, :flash => result
  end

  def remove_article
    result = @service.delete_article(params, current_user)
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
