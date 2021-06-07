class Admin::CustomerService
  def get_customer_list(page)
    data = Customer.where({}).order_by(updated_at: :desc).page(page).per(25)
    total_data = data.total_count
    total_pages = data.total_pages
    datas = ActiveModel::Serializer::CollectionSerializer.new(data, serializer: CustomerSerializer)
    return get_table_data(page, "customer", datas, total_data, total_pages)
  end

  def search_customer(params)
    search_query = get_query_search(params)
    data = Customer.where(search_query).order_by(updated_at: :desc)
    total_data = data.size
    total_pages = 1
    page = 1
    datas = ActiveModel::Serializer::CollectionSerializer.new(data, serializer: CustomerSerializer)
    return get_table_data(page, "customer", datas, total_data, total_pages)
  end

  def get_customer_detail(id)
    data = Customer.find(id)
    datas = ActiveModel::SerializableResource.new(data, serializer: CustomerDetailSerializer)
    return datas
  end

  def add_customer(params, current_user)
    begin
      customer = Customer.find_by_phone(params[:phone])
      if !customer.present?
        data = {
          firstname: params[:firstname],
          lastname: params[:lastname],
          phone: params[:phone],
          email: params[:email],
          address: params[:address],
          is_active: params[:is_active],
          join_date: Date.today,
          created_by: current_user,
          moderated_by: current_user,
        }
        binding.pry
        new_customer = Customer.new(data)
        if new_customer.save!
          return { status: "success", message: "Success Create New Customer" }
        else
          return { status: "failed", message: new_customer.errors.to_s }
        end
      else
        return { status: "failed", message: "Customer already exists" }
      end
    rescue Exception => e
      return { status: "failed", message: e.message }
    end
  end

  def update_customer(params, current_user)
    begin
      customer = Customer.find(params[:id])
      if Customer.present?
        data = {
          firstname: params[:firstname],
          lastname: params[:lastname],
          phone: params[:phone],
          email: params[:email],
          address: params[:address],
          is_active: params[:is_active],
          moderated_by: current_user,
        }
        if customer.update_attributes(data)
          return { status: "success", message: "Success Update Customer" }
        else
          return { status: "failed", message: customer.errors.to_s }
        end
      else
        return { status: "failed", message: "Customer not found" }
      end
    rescue Exception => e
      return { status: "failed", message: e.message }
    end
  end

  def delete_customer(params, current_user)
    begin
      customer = Customer.find(params[:id])
      if customer.present?
        if customer.destroy
          return { status: "success", message: "Success delete Customer" }
        else
          return { status: "failed", message: customer.errors.to_s }
        end
      else
        return { status: "failed", message: "Customer not found" }
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
    query = params[:query].downcase
    search_query = {}
    if type_search == "id"
      search_query[:id] = query
    elsif type_search == "name"
      search_query = {
        "$or": [
          { firstname: /^#{query}$/i },
          { lastname: /^#{query}$/i },
        ],
      }
    elsif type_search == "email"
      search_query[:email] = /^#{query}$/i
    elsif type_search == "phone"
      search_query[:phone] = /^#{query}$/i
    end
    return search_query
  end
end
