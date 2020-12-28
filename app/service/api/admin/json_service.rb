class Api::Admin::JsonService
  def user_result_json(status, user, message)
    data = {}
    if user.present?
      token = JsonWebToken.encode(user_id: user.id.to_s)
      time = Time.now + 24.hours.to_i
      role = user.role.present? ? user.role : "user" 
      data = {
        uid: user.id.to_s,
        email: user.email,
        token: token,
        exp: time.strftime("%m-%d-%Y %H:%M"),
        role: role
      }
      user.update_attributes(token: token)
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
