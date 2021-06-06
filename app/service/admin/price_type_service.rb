class Admin::PriceTypeService
  def get_price_type_list(page)
    data = PriceType.where({}).order_by(updated_at: :desc).page(page).per(25)
    total_data = data.total_count
    total_pages = data.total_pages
    datas = ActiveModel::Serializer::CollectionSerializer.new(data, serializer: PriceTypeSerializer)
    return get_table_data(page, "price_type", datas, total_data, total_pages)
  end

  def search_price_type(params)
    search_query = get_query_search(params)
    data = PriceType.where(search_query).order_by(updated_at: :desc)
    total_data = data.size
    total_pages = 1
    page = 1
    datas = ActiveModel::Serializer::CollectionSerializer.new(data, serializer: PriceTypeSerializer)
    return get_table_data(page, "price_type", datas, total_data, total_pages)
  end

  def add_price_type(params, current_user)
    begin
      price_type = PriceType.find_by_name(params[:name])
      if !price_type.present?
        data = {
          name: params[:name],
          desc: params[:desc],
          is_active: params[:is_active],
          created_by: current_user,
          moderated_by: current_user,
        }
        new_price_type = PriceType.new(data)
        if new_price_type.save!
          return { status: "success", message: "Success Create New PriceType" }
        else
          return { status: "failed", message: new_price_type.errors.to_s }
        end
      else
        return { status: "failed", message: "PriceType already exists" }
      end
    rescue Exception => e
      return { status: "failed", message: e.message }
    end
  end

  def update_price_type(params, current_user)
    begin
      price_type = PriceType.find(params[:id])
      if price_type.present?
        data = {
          name: params[:name],
          desc: params[:desc],
          is_active: params[:is_active],
          moderated_by: current_user,
        }
        if price_type.update_attributes(data)
          return { status: "success", message: "Success Update PriceType" }
        else
          return { status: "failed", message: price_type.errors.to_s }
        end
      else
        return { status: "failed", message: "PriceType not found" }
      end
    rescue Exception => e
      return { status: "failed", message: e.message }
    end
  end

  def delete_price_type(params, current_user)
    begin
      price_type = PriceType.find(params[:id])
      if price_type.present?
        if price_type.destroy
          return { status: "success", message: "Success delete PriceType" }
        else
          return { status: "failed", message: price_type.errors.to_s }
        end
      else
        return { status: "failed", message: "PriceType not found" }
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
    search_query = {}
    if type_search == "id"
      search_query[:id] = query
    elsif type_search == "name"
      search_query[:name] = query
    end
    return search_query
  end
end
