class Api::V1::RegistrationsController < Api::V1::ApplicationController
  respond_to :json

  def sign_up
    begin
      user = User.find_by_email(params[:email])
      if !user.present?
        new_user = User.new(email: params[:email], password: params[:password])
        if new_user.save!
          user_data = get_result_data(new_user)
          result = get_success_result(user_data, "Success create new user")
          render :json => result, :status => 200
        else
          result = get_error_result("Failed to create new user", 500, new_user.errors.to_s)
          render :json => result, :status => 200
        end
      else
        result = get_error_result("Failed to create new user", 500, "Email has been taken")
        render :json => result, :status => 200
      end
    rescue Exception => e
      result = get_error_result("Failed to create new user", 500, e.message)
      render :json => result, :status => 500
    end
  end

  private
  def get_result_data(status, message_data, user)
    if user.present?
      data = {
        uid: user.id.to_s,
        email: user.email,
      }
    else
      data = nil
    end
   return data
  end
end
