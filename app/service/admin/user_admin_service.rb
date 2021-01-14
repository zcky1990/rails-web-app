class Admin::UserAdminService
  def get_user_list(type, page)
    data = User.where({ role: type }).order_by(updated_at: :desc).page(page).per(25)
    total_data = data.total_count
    total_pages = data.total_pages
    datas = ActiveModel::Serializer::CollectionSerializer.new(data, serializer: Admin::UserAdminSerializer)
    return get_table_data(page, type, datas, total_data, total_pages)
  end

  def search_user(params)
    search_query = get_query_search(params)
    data = User.where(search_query).order_by(updated_at: :desc)
    total_data = data.size
    total_pages = 1
    page = 1
    datas = ActiveModel::Serializer::CollectionSerializer.new(data, serializer: Admin::UserAdminSerializer)
    return get_table_data(page, params[:type], datas, total_data, total_pages)
  end

  def remove_user(params)
    begin
      user = User.find(params[:id])
      if user.present?
        if user.delete
          return { status: "success", message: "Success remove user admin data" }
        else
          return { status: "failed", message: user.errors.to_s }
        end
      else
        return { status: "failed", message: "User admin not found" }
      end
    rescue Exception => e
      return { status: "failed", message: e.message }
    end
  end

  def add_user(params)
    begin
      user = User.find_by_email(params[:email])
      if !user.present?
        data = {
          email: params[:email],
          password: params[:password],
          first_name: params[:first_name],
          last_name: params[:last_name],
          role: params[:type],
          access_level: params[:access_level],
        }
        new_user = User.new(data)
        if new_user.save!
          return { status: "success", message: "Success Create New User admin" }
        else
          return { status: "failed", message: new_user.errors.to_s }
        end
      else
        return { status: "failed", message: "User admin already exists" }
      end
    rescue Exception => e
      return { status: "failed", message: e.message }
    end
  end

  def update_user(params)
    begin
      user = User.find(params[:id])
      if user.present?
        data = {}
        data[:email] = params[:email]
        data[:password] = params[:password] if params[:password].present?
        data[:first_name] = params[:first_name]
        data[:last_name] = params[:last_name]
        data[:role] = params[:role]
        data[:access_level] = params[:access_level]
        if user.update_attributes(data)
          return { status: "success", message: "Success Update User admin data" }
        else
          return { status: "failed", message: user.errors.to_s }
        end
      else
        return { status: "failed", message: "User admin Not found" }
      end
    rescue Exception => e
      return { status: "failed", message: e.message }
    end
  end

  private

  def get_table_data(page, type, datas, total_data, total_Page)
    return {
             type: type,
             tabelData: datas,
             pagination_options: {
               total_data: total_data,
               total_page: total_Page,
               page: page,
             },
           }
  end

  def get_query_search(params)
    type_search = params[:typeSearch]
    query = params[:query]
    type = params[:type]
    search_query = {
      role: type,
    }
    if type_search == "id"
      search_query[:id] = query
    elsif type_search == "email"
      search_query[:email] = query
    elsif type_search == "phone_number"
      search_query[:phone_number] = query
    end
    return search_query
  end
end
