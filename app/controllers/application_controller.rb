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

  def get_token(current_user = nil)
    if current_user.present?
      return current_user.token
    else
      return ENV["TOKEN"]
    end
  end

  def get_default_web_meta_data
    web_meta = $redis.get("web_meta_data")
    if web_meta.present?
      return JSON.parse(web_meta)
    else
      web_data = WebMeta.where({}).first
      if web_data.present?
        data = {
          id: web_data.id.to_s,
          title: web_data.title, 
          description: web_data.description,
          keywords: web_data.keywords,
          image_url: web_data.image_url,
          icon_image_url: web_data.icon_image_url
        }
        return data
      else
        return {}
      end
    end
  end
  
end
