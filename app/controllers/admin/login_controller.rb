class Admin::LoginController < ApplicationController
  before_action :check_is_admin_login

  def login
  end

  def check_is_admin_login
    if current_admin.present?
      redirect_to '/admin/dashboard'
    end
  end
  
end
