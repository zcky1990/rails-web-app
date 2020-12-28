class ApplicationController < ActionController::Base
  layout "application"

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
        @current_user = User.find(@decoded[:user_id])
      end
    rescue Exception => e
      render json: { errors: e.message }, status: :unauthorized
    end
  end

  def get_token(current_user = nil)
    if current_user.present?
      return current_user.token
    else
      return ENV["TOKEN"]
    end
  end
end
