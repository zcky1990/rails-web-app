class Admin::ProductService
  def get_product_list(page)
    data = Product.where({}).order_by(updated_at: :desc).page(page).per(25)
    total_data = data.total_count
    total_pages = data.total_pages
    datas = ActiveModel::Serializer::CollectionSerializer.new(data, serializer: ProductSerializer)
    return get_table_data(page, "product", datas, total_data, total_pages)
  end

  def search_product(params)
    search_query = get_query_search(params)
    data = Product.where(search_query).order_by(updated_at: :desc)
    total_data = data.size
    total_pages = 1
    page = 1
    datas = ActiveModel::Serializer::CollectionSerializer.new(data, serializer: ProductSerializer)
    return get_table_data(page, "product", datas, total_data, total_pages)
  end

  def add_product(params, current_user)
    begin
      product = Product.find_by_name(params[:name])
      if !product.present?
        data = {
          name: params[:name],
          stock: params[:stock],
          moderated_by: current_user,
          created_by: current_user,
          is_active: params[:is_active],
        }
        if params[:product_category_id].present?
          category = Category.find(params[:product_category_id])
          product_category = ProductCategory.new(category: category)
          data[:product_category] = product_category
        end
        if params[:price].present?
          new_prices = []
          prices = params[:price]
          prices.each do |a|
            price_type = PriceType.find(a[:price_type_id])
            new_price_params = {
              price_type: price_type,
              price: a[:price],
            }
            new_price = Price.new(new_price_params)
            new_prices << new_price
          end
          data[:price] = new_prices
        end
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

  def update_product(params, current_user)
    begin
      product = Product.find(params[:id])
      if product.present?
        data = {
          name: params[:name],
          stock: params[:stock],
          moderated_by: current_user,
          is_active: params[:is_active],
        }
        if params[:product_category_id].present?
          category = Category.find(params[:product_category_id])
          product_category = ProductCategory.new(category: category)
          data[:product_category] = product_category
        end
        if params[:price].present?
          new_prices = []
          prices = params[:price]
          prices.each do |a|
            price_type = PriceType.find(a[:price_type_id])
            new_price_params = {
              price_type: price_type,
              price: a[:price],
            }
            new_price = Price.new(new_price_params)
            new_prices << new_price
          end
          data[:price] = new_prices
        end

        if product.update_attributes(data)
          return { status: "success", message: "Success Update Product" }
        else
          return { status: "failed", message: product.errors.to_s }
        end
      else
        return { status: "failed", message: "Product not found" }
      end
    rescue Exception => e
      return { status: "failed", message: e.message }
    end
  end

  def delete_product(params, current_user)
    begin
      product = Product.find(params[:id])
      if product.present?
        if product.destroy
          return { status: "success", message: "Success delete Product" }
        else
          return { status: "failed", message: product.errors.to_s }
        end
      else
        return { status: "failed", message: "Product not found" }
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
    elsif type_search == "price"
      search_query["price.price"] = query
    elsif type_search == "price_type"
      search_query["price.price_type.name"] = query
    elsif type_search == "product_category"
      search_query["product_category.category.name"] = query
    elsif type_search == "price"
      search_query[:price] = query
    end
    return search_query
  end
end
