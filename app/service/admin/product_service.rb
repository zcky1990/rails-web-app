class Admin::ProductService
  def get_category_list(page)
    data = Category.where({ is_active: true }).hint({ is_active: 1 }).order_by(updated_at: :desc).page(page).per(25)
    total_data = data.total_count
    total_pages = data.total_pages
    datas = ActiveModel::Serializer::CollectionSerializer.new(data, serializer: CategorySerializer)
    return get_table_data(page, "category", datas, total_data, total_pages)
  end

  def search_category(params)
    search_query = get_query_search(params)
    data = Category.where(search_query).order_by(updated_at: :desc)
    total_data = data.size
    total_pages = 1
    page = 1
    datas = ActiveModel::Serializer::CollectionSerializer.new(data, serializer: CategorySerializer)
    return get_table_data(page, "category", datas, total_data, total_pages)
  end

  def add_product(params, current_user)
    begin
      product = Product.find_by_name(params[:name])
      if !product.present?
        category = Category.find(params[:category_id])
        data = {
          name: params[:name],
          stock: params[:stock],
          price: params[:price],
          product_category_id: category,
          created_by: current_user,
          moderated_by: current_user
        }
        binding.pry
        new_product = Product.new(data)
       
        if new_product.save!
          return { status: "success", message: "Success Create New Product" }
        else
          return { status: "failed", message: new_product.errors.to_s }
        end
      else
        return { status: "failed", message: "Product already exists" }
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
    elsif type_search == "status"
      search_query[:is_active] = query
    end
    return search_query
  end
end
