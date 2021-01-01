class Api::Admin::UserService
  def get_admin_list(params)
    begin
      data = User.where({ role: "admin" }).order_by(updated_at: :desc).page(params[:page]).per(25)
      if data.present?
        total_data = data.total_count
        total_pages = data.total_pages
        datas = ActiveModel::Serializer::CollectionSerializer.new(data, serializer: UserAdminSerializer)
        return Api::SuccessListResult.new(data: datas, message: "Success get admin list at page : #{params[:page]}", total_data: total_data, total_page: total_pages)
      else
        return {}
      end
    rescue Exception => e
      return Api::ErrorResult.new(error_code: 500, error_title: "Failed to get list", error_message: e.message)
    end
  end

  def remove_admin(params)
    begin
      admin = User.find(params[:id])
      if admin.present?
        if admin.delete
          return Api::SuccessObjectResult.new(data: {}, message: "Success remove Admin")
        else
          return Api::ErrorResult.new(error_code: 500, error_title: "Failed to Delete Admin", error_message: admin.errors.to_s)
        end
      else
        return Api::ErrorResult.new(error_code: 500, error_title: "Failed to Delete Admin", error_message: "User not found")
      end
    rescue Exception => e
      return Api::ErrorResult.new(error_code: 500, error_title: "Failed to Delete new Admin", error_message: e.message)
    end
  end

  def add_admin(params)
    begin
      admin = User.find_by_email(params[:email])
      if !admin.present?
        data = {
          email: params[:email],
          password: params[:password],
          first_name: params[:first_name],
          last_name: params[:last_name],
          role: "admin",
        }
        new_admin = User.new(data)
        if new_admin.save!
          data = UserAdminSerializer.new(new_admin).as_json
          return Api::SuccessObjectResult.new(data: data, message: "Success create new Admin")
        else
          return Api::ErrorResult.new(error_code: 500, error_title: "Failed to create new Admin", error_message: new_admin.errors.to_s)
        end
      else
        return Api::ErrorResult.new(error_code: 500, error_title: "Failed to create new Admin", error_message: "User already exists")
      end
    rescue Exception => e
      return Api::ErrorResult.new(error_code: 500, error_title: "Failed to create new Admin", error_message: e.message)
    end
  end

  def update_admin(params)
    begin
      admin = User.find(params[:id])
      if admin.present?
        data = {
          email: params[:email],
          password: params[:password],
          first_name: params[:first_name],
          last_name: params[:last_name],
          role: "admin",
        }
        if admin.update_attributes(data)
          data = UserAdminSerializer.new(admin).as_json
          return Api::SuccessObjectResult.new(data: data, message: "Success Update")
        else
          return Api::ErrorResult.new(error_code: 500, error_title: "Failed to update", error_message: admin.errors.to_s)
        end
      else
        return Api::ErrorResult.new(error_code: 500, error_title: "Failed to update", error_message: "User Not found")
      end
    rescue Exception => e
      return Api::ErrorResult.new(error_code: 500, error_title: "Failed to update", error_message: e.message)
    end
  end

  def get_user_list(params)
    begin
      data = User.where({ role: "user" }).order_by(updated_at: :desc).page(params[:page]).per(25)
      if data.present?
        total_data = data.total_count
        total_pages = data.total_pages
        datas = ActiveModel::Serializer::CollectionSerializer.new(data, serializer: UserAdminSerializer)
        return Api::SuccessListResult.new(data: datas, message: "Success get user list at page : #{params[:page]}", total_data: total_data, total_page: total_pages)
      else
        return {}
      end
    rescue Exception => e
      return Api::ErrorResult.new(error_code: 500, error_title: "Failed to get list", error_message: e.message)
    end
  end

  def remove_user(params)
    begin
      user = User.find(params[:id])
      if user.present?
        if user.delete
          return Api::SuccessObjectResult.new(data: {}, message: "Success remove User")
        else
          return Api::ErrorResult.new(error_code: 500, error_title: "Failed to Delete User", error_message: user.errors.to_s)
        end
      else
        return Api::ErrorResult.new(error_code: 500, error_title: "Failed to Delete User", error_message: "User not found")
      end
    rescue Exception => e
      return Api::ErrorResult.new(error_code: 500, error_title: "Failed to Delete new User", error_message: e.message)
    end
  end

  def add_user(params)
    begin
      admin = User.find_by_email(params[:email])
      if !admin.present?
        data = {
          email: params[:email],
          password: params[:password],
          first_name: params[:first_name],
          last_name: params[:last_name],
          role: "user",
        }
        new_admin = User.new(data)
        if new_admin.save!
          data = UserAdminSerializer.new(new_admin).as_json
          return Api::SuccessObjectResult.new(data: data, message: "Success create new User")
        else
          return Api::ErrorResult.new(error_code: 500, error_title: "Failed to create new User", error_message: new_admin.errors.to_s)
        end
      else
        return Api::ErrorResult.new(error_code: 500, error_title: "Failed to create new User", error_message: "User already exists")
      end
    rescue Exception => e
      return Api::ErrorResult.new(error_code: 500, error_title: "Failed to create new User", error_message: e.message)
    end
  end

  def update_user(params)
    begin
      admin = User.find(params[:id])
      if admin.present?
        data = {
          email: params[:email],
          password: params[:password],
          first_name: params[:first_name],
          last_name: params[:last_name],
          role: "user",
        }
        if admin.update_attributes(data)
          data = UserAdminSerializer.new(admin).as_json
          return Api::SuccessObjectResult.new(data: data, message: "Success Update User")
        else
          return Api::ErrorResult.new(error_code: 500, error_title: "Failed to update User", error_message: admin.errors.to_s)
        end
      else
        return Api::ErrorResult.new(error_code: 500, error_title: "Failed to update User", error_message: "User Not found")
      end
    rescue Exception => e
      return Api::ErrorResult.new(error_code: 500, error_title: "Failed to update User", error_message: e.message)
    end
  end
end
