class  Api::V1::SessionsController < Api::V1::ApplicationController
    respond_to :json

    def login
      user = User.find_by_email(params[:email])
      if user.present?
        if user.valid_password?(params[:password])
          if user_signed_in?
            result = user_result_json(SUCCESS, user, USER_ALREADY_LOGIN)
          else
            sign_in user
            result = user_result_json(SUCCESS, user, USER_SUCCESS_LOGIN)
          end
          render :json=> result, :status=>200
        else
          result = user_result_json(FAILED, nil, ERROR_FAILED_LOGIN)
          render :json=> result, :status=>200
        end
      else
        result = user_result_json(FAILED, nil, ERROR_FAILED_LOGIN)
        render :json=> result, :status=>200
      end
    end

    def logout
        if @current_user.present?
          sign_out(@current_user)
          result = user_result_json(SUCCESS, nil, SUCCESS_LOGOUT)
          render :json=> result, :status=>200
        else
          result = user_result_json(FAILED, nil, ERROR_FAILED_LOGOUT)
          render :json=> result, :status=>200
        end
    end
    
    private
      def user_result_json(status, user, message)
        data = {}
        if user.present?
          token = JsonWebToken.encode(user: user)
          time = Time.now + 24.hours.to_i
          data = { 
            uid: user.id.to_s,
            email: user.email,
            token: token, 
            exp: time.strftime("%m-%d-%Y %H:%M")
          }
        end

        result = {
          status: status,
          data: { 
            data: data,
            message: message}
          }
        return result
      end
  end
  