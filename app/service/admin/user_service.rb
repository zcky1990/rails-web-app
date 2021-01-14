class Admin::UserService
  def get_user_list(type, page)
    data = User.where({ role: type }).order_by(updated_at: :desc).page(page).per(25)
    total_data = data.total_count
    total_pages = data.total_pages
    datas = ActiveModel::Serializer::CollectionSerializer.new(data, serializer: Admin::UserSerializer)
    return get_table_data(page, type, datas, total_data, total_pages)
  end

  def search_user(params)
    search_query = get_query_search(params)
    data = User.where(search_query).order_by(updated_at: :desc)
    total_data = data.size
    total_pages = 1
    page = 1
    datas = ActiveModel::Serializer::CollectionSerializer.new(data, serializer: Admin::UserSerializer)
    return get_table_data(page, params[:type], datas, total_data, total_pages)
  end

  def remove_user(params)
    begin
      user = User.find(params[:id])
      if user.present?
        if user.delete
          return { status: "success", message: "Success remove user data" }
        else
          return { status: "failed", message: user.errors.to_s }
        end
      else
        return { status: "failed", message: "User not found" }
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
          address: params[:address],
          postal_code: params[:postal_code],
          avatar_img_url: params[:avatar_img_url],
          phone_number: params[:phone_number],
          gender: params[:gender],
          description: params[:description],
          birthday: params[:birthday],
        }
        new_user = User.new(data)
        if new_user.save!
          return { status: "success", message: "Success Create New User" }
        else
          return { status: "failed", message: new_user.errors.to_s }
        end
      else
        return { status: "failed", message: "User already exists" }
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
        data[:address] = params[:address]
        data[:postal_code] = params[:postal_code]
        data[:avatar_img_url] = params[:avatar_img_url]
        data[:phone_number] = params[:phone_number]
        data[:gender] = params[:gender]
        data[:description] = params[:description]
        data[:birthday] = params[:birthday]
        if user.update_attributes(data)
          return { status: "success", message: "Success Update User data" }
        else
          return { status: "failed", message: user.errors.to_s }
        end
      else
        return { status: "failed", message: "User Not found" }
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
