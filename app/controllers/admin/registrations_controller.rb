class Admin::RegistrationsController < Devise::RegistrationsController
  respond_to :json

  def new
    user = Admin.find_by_email(params[:email])
    if !user.present?
      new_user = Admin.new(email: params[:email], password: params[:password ])
      if new_user.save!
          result = create_result_json("success", "Success create new user")
          render :json=> result, :status=>200
        return
      else
        result = create_result_json("failed", new_user.errors.to_s)
        render :json=> result, :status=>200
        return
      end
    else
      result = create_result_json("failed", "email has been taken")
      render :json=> result, :status=>200
    end
  end

  def create
    user = Admin.find_by_email(params[:email])
    if !user.present?
      new_user = Admin.new(email: params[:email], password: params[:password ])
      if new_user.save!
          result = create_result_json("success", "Success create new user")
          render :json=> result, :status=>200
        return
      else
        result = create_result_json("failed", new_user.errors.to_s)
        render :json=> result, :status=>200
        return
      end
    else
      result = create_result_json("failed", "email has been taken")
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
