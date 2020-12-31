class Api::Admin::ApplicationController < ActionController::API
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
end
