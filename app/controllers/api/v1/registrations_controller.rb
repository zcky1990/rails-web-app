class Api::V1::RegistrationsController < Api::V1::ApplicationController
  respond_to :json

  def sign_up
    user = User.find_by_email(params[:email])
    if !user.present?
      new_user = User.new(email: params[:email], password: params[:password ])
      if new_user.save!
          result = get_result(SUCCESS, SUCCESS_CREATE_USER, new_user)
          render :json=> result, :status=>200
      else
        result = get_result(FAILED, new_user.errors.to_s, nil)
        render :json=> result, :status=>200
      end
    else
      result = get_result(FAILED, ERROR_EMAIL_TAKEN, nil)
      render :json=> result, :status=>200
    end
  end

  private
    def get_result(status,message_data, user)
      if user.present?
      data = {
        uid: user.id.to_s,
        email: user.email
      }
    else
      data = nil
    end
      result = {
        status: status,
        data: { 
          data: data,
          message: message_data
        }
      }
      return result
    end
end
