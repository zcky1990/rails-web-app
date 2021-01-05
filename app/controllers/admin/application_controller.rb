class Admin::ApplicationController < ApplicationController
  def is_sign_in
    if !user_signed_in?
      redirect_to "/admin/login"
    end
  end

  def get_notif(flash)
    if flash.present?
      return { status: flash[:status], message: flash[:message] }
    else
      return {}
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
          icon_image_url: web_data.icon_image_url,
        }
        return data
      else
        return {}
      end
    end
  end
end
