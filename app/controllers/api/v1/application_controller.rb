class Api::V1::ApplicationController < ActionController::API
  def not_found
    render json: { error: "not_found" }
  end

  def authorize_request
    header = request.headers["Authorization"]
    header = header.split(" ").last if header
    begin
      @decoded = JsonWebToken.decode(header)
      if @decoded[:app_name].present?
        if @decoded[:app_name] != ENV["APP_NAME"]
          render json: { errors: "Invalid Token"}, status: :unauthorized
        end
      else
        @current_user = User.find(@decoded[:user_id])
      end
    rescue Exception => e
      render json: { errors: e.message }, status: :unauthorized
    end
  end

  def get_error_result(error_title, error_code, error_message)
    result = {
      status: "error",
      data: {
        error_title: error_title,
        error_code: error_code,
        error_message: error_message
      }
    }
    return result
  end

  def get_success_result(data, message_data)
    result = {
      status: "success",
      data: {
        data: data,
        message: message_data
      }
    }
    return result
  end
end
