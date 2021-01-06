class Admin::UserService
  def get_user_list(type, page)
    data = User.where({ role: type }).order_by(updated_at: :desc).page(page).per(25)
    total_data = data.total_count
    total_pages = data.total_pages
    table_header = ["id", "email", "first_name", "last_name", "role"]
    hidden_column = [0]
    datas = ActiveModel::Serializer::CollectionSerializer.new(data, serializer: UserAdminSerializer)
    return get_table_data(page, type, datas, total_data, total_pages, table_header, hidden_column, 25)
  end

  def search_user(params)
    search_query = get_query_search(params)
    data = User.where(search_query).order_by(updated_at: :desc)
    total_data = data.size
    total_pages = 1
    table_header = ["id", "email", "first_name", "last_name", "role"]
    hidden_column = [0]
    datas = ActiveModel::Serializer::CollectionSerializer.new(data, serializer: UserAdminSerializer)
    return get_table_data(1, params[:type], datas, total_data, 1, table_header, hidden_column, 1000)
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
          role: params[:type],
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
        data[:role] = params[:role]
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

  def get_table_data(page, type, datas, total_data, total_Page, table_header, hidden_column, maxRow)
    return {
             page: page,
             type: type,
             tabelData: datas,
             total_data: total_data,
             total_page: total_Page,
             tableHeaders: table_header,
             hiddenColumn: hidden_column,
             maxRow: maxRow,
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
    end
    return search_query
  end
end
