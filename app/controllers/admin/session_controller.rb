class Admin::SessionController < Devise::SessionsController
  respond_to :json

  def create
    user = Admin.find_by_email(params[:email])
    if user.present?
      if user.valid_password?(params[:password])
        cookies[:new_user_admin_sign_in] = 'user_admin_sign_in'
        cookies[:role] = 'ADMIN'
        sign_in user
        result = create_result_json("success", "Success Admin Login")
        render :json=> result, :status=>200
      else
        cookies.delete :new_user_admin_sign_in
        cookies.delete :role
        result = create_result_json("failed", "Failed Admin Login, password invalid")
        render :json=> result, :status=>200
      end
    else
      result = create_result_json("failed", "User not found")
      render :json=> result, :status=>200
    end
  end
  
  private
    def create_result_json(status,message_data)
      result = {
        status: status,
        data: { 
          message: message_data}
        }
      return result
    end
end
