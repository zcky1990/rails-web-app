class Api::V1::JwtController < Api::V1::ApplicationController
  before_action :authorize_request, except: :generate_jwt
  respond_to :json

  def generate_jwt
    token = JsonWebToken.encode(app_name: ENV["APP_NAME"])
    time = Time.now + 24.hours.to_i
    render json: { token: token, exp: time.strftime("%m-%d-%Y %H:%M") }, status: :ok
  end
end
