class Admin::AdminApplicationController < ApplicationController
  before_action :check_is_admin, :get_admin_jwt, :authenticate_admin!

  def check_is_admin
    if !current_admin.present?
      redirect_to '/'
    end
  end

  def encode_token(payload)
    JWT.encode(payload, ENV['SECRET_KEY'], 'HS256')
  end

  def auth_header
    request.headers['Authorization']
  end

  def decoded_token
    if auth_header
      token = auth_header.split(' ')[1]
      begin
        JWT.decode(token, ENV['SECRET_KEY'], true, algorithm: 'HS256')
      rescue JWT::DecodeError
        nil
      end
    end
  end

  def get_admin_jwt(valid_for_minutes = 10)
    user_id = current_admin.id.to_s
    exp = Time.now.to_i + (valid_for_minutes*60)
    payload = { "user_id": user_id,
                "exp": exp,
                "name": "admin",
                "roles": ["ADMIN"]
    }
    @jwt = encode_token(payload)
  end


  def logged_in_admin
    if decoded_token
      user_id = decoded_token[0]['user_id']
      @user = Admin.find_by(id: user_id)
    end
  end

  def logged_in?
    !!logged_in_admin
  end

  def authorized
    render json: { message: 'Please log in' }, status: :unauthorized unless logged_in?
  end
  
end
