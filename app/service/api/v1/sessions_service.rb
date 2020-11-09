class Api::V1::SessionsService < Api::V1::JsonService
  def set_user_result_json(status, data, message)
    return user_result_json(status, data, message)
  end

  def sign_in_user(params, is_user_sign_in, callback)
    user = User.find_by_email(params[:email])
    if user.present?
      if user.valid_password?(params[:password])
        if is_user_sign_in
          return user_result_json(SUCCESS, user, USER_ALREADY_LOGIN)
        else
          callback.call(user)
          return user_result_json(SUCCESS, user, USER_SUCCESS_LOGIN)
        end
      else
        return user_result_json(FAILED, nil, ERROR_FAILED_LOGIN)
        render :json => result, :status => 200
      end
    else
      return user_result_json(FAILED, nil, ERROR_FAILED_LOGIN)
      render :json => result, :status => 200
    end
  end

  def sign_out_user(user, callback)
    if user.present?
      callback.call(user)
      return user_result_json(SUCCESS, nil, SUCCESS_LOGOUT)
    else
      return user_result_json(FAILED, nil, ERROR_FAILED_LOGOUT)
    end
  end

  def sign_in_user_omni_auth(type, provider_data, callback)
    user = User.find_by_omniauth_id(type, provider_data[:uid])
    if user.present?
      callback.call(user)
      return user_result_json(SUCCESS, user, USER_SUCCESS_LOGIN)
    else
      oauth_user_data = {}
      if type == FB_LOGIN
        oauth_user_data = { facebook_uid: provider_data[:uid] }
      elsif type == GOOGLE_LOGIN
        oauth_user_data = { google_uid: provider_data[:uid] }
      elsif type == TWITTER_LOGIN
        oauth_user_data = { twitter_uid: provider_data[:uid] }
      end
      oauth_user_data["email"] = provider_data[:email]
      oauth_user_data["firstname"] = provider_data[:firstname] rescue nil
      oauth_user_data["lastname"] = provider_data[:lastname] rescue nil
      oauth_user_data["avatar_img_url"] = provider_data[:user_image] rescue nil

      new_user = User.new(oauth_user_data)
      if new_user.save(validate: false)
        return user_result_json(SUCCESS, user, USER_SUCCESS_LOGIN)
      else
        return user_result_json(FAILED, nil, ERROR_FAILED_LOGIN)
      end
    end
  end
end
