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
        #dont do anything
      else
        @current_user = User.find(@decoded[:user])
      end
    rescue ActiveRecord::RecordNotFound => e
      render json: { errors: e.message }, status: :unauthorized
    rescue JWT::DecodeError => e
      render json: { errors: e.message }, status: :unauthorized
    end
  end

  def result_json(status, response, message)
    data = {}
    if response.present?
      data = response
    end
    result = {
      status: status,
      data: {
        data: data,
        message: message,
      },
    }
    return result
  end
end
