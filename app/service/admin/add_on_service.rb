class Admin::AddOnService
  def get_add_on_list(page)
    data = AddOn.where({}).order_by(updated_at: :desc).page(page).per(25)
    total_data = data.total_count
    total_pages = data.total_pages
    datas = ActiveModel::Serializer::CollectionSerializer.new(data, serializer: AddOnSerializer)
    return get_table_data(page, "add_on", datas, total_data, total_pages)
  end

  def search_add_on(params)
    search_query = get_query_search(params)
    data = AddOn.where(search_query).order_by(updated_at: :desc)
    total_data = data.size
    total_pages = 1
    page = 1
    datas = ActiveModel::Serializer::CollectionSerializer.new(data, serializer: AddOnSerializer)
    return get_table_data(page, "add_on", datas, total_data, total_pages)
  end

  def add_add_on(params, current_user)
    begin
      add_on = AddOn.find_by_name(params[:name])
      if !add_on.present?
        data = {
          name: params[:name],
          price: params[:price],
          is_active: params[:is_active],
          created_by: current_user,
          moderated_by: current_user,
        }
        new_add_on = AddOn.new(data)
        if new_add_on.save!
          return { status: "success", message: "Success Create New Add-On" }
        else
          return { status: "failed", message: new_add_on.errors.to_s }
        end
      else
        return { status: "failed", message: "Add-On already exists" }
      end
    rescue Exception => e
      return { status: "failed", message: e.message }
    end
  end

  def update_add_on(params, current_user)
    begin
      add_on = AddOn.find(params[:id])
      if add_on.present?
        data = {
          name: params[:name],
          price: params[:price],
          is_active: params[:is_active],
          moderated_by: current_user,
        }
        if add_on.update_attributes(data)
          return { status: "success", message: "Success Update Add-On" }
        else
          return { status: "failed", message: add_on.errors.to_s }
        end
      else
        return { status: "failed", message: "Add-On not found" }
      end
    rescue Exception => e
      return { status: "failed", message: e.message }
    end
  end

  def delete_add_on(params, current_user)
    begin
      add_on = AddOn.find(params[:id])
      if add_on.present?
        if add_on.destroy
          return { status: "success", message: "Success delete Add-On" }
        else
          return { status: "failed", message: add_on.errors.to_s }
        end
      else
        return { status: "failed", message: "Add-On not found" }
      end
    rescue Exception => e
      return { status: "failed", message: e.message }
    end
  end

  def get_add_on_dropdown_list
    begin
      data = AddOn.where({ is_active: true }).hint({ is_active: 1 }).order_by(name: :asc)
      datas = ActiveModel::Serializer::CollectionSerializer.new(data, serializer: AddOnSerializer)
      return Api::SuccessListResult.new(data: datas, message: "success get add-On list")
    rescue Exception => e
      return Api::ErrorResult.new(error_code: 500, error_title: "Error get add-On list", error_message: e.message)
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
    query = params[:query].downcase
    search_query = {}
    if type_search == "id"
      search_query[:id] = query
    elsif type_search == "name"
      search_query[:name] = /^#{query}$/i
    elsif type_search == "price"
      search_query[:price] = query
    end
    return search_query
  end
end
