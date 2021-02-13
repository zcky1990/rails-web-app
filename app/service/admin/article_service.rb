class Admin::ArticleService
  def get_article_list(page)
    data = Category.where({ is_active: true }).hint({ is_active: 1 }).order_by(updated_at: :desc).page(page).per(25)
    total_data = data.total_count
    total_pages = data.total_pages
    datas = ActiveModel::Serializer::CollectionSerializer.new(data, serializer: CategorySerializer)
    return get_table_data(page, "category", datas, total_data, total_pages)
  end

  def search_article(params)
    search_query = get_query_search(params)
    data = Category.where(search_query).order_by(updated_at: :desc)
    total_data = data.size
    total_pages = 1
    page = 1
    datas = ActiveModel::Serializer::CollectionSerializer.new(data, serializer: CategorySerializer)
    return get_table_data(page, "category", datas, total_data, total_pages)
  end

  def add_article(params, current_user)
    begin
      category = Article.find_by_slug(params[:slug])
      if !category.present?
        data = {
          slug: params[:slug],
          title: params[:title],
          content: params[:content],
          is_publish: false,
          categories: params[:categories],
          created_by: current_user,
          moderated_by: current_user,
        }
        new_category = Article.new(data)
        if new_category.save!
          return { status: "success", message: "Success Create New Article" }
        else
          return { status: "failed", message: new_category.errors.to_s }
        end
      else
        return { status: "failed", message: "Article already exists" }
      end
    rescue Exception => e
      return { status: "failed", message: e.message }
    end
  end

  def update_article(params, current_user)
    begin
      category = Category.find(params[:id])
      if category.present?
        data = {
          name: params[:name],
          desc: params[:desc],
          status: params[:status],
          moderated_by: current_user,
        }
        if category.update_attributes(data)
          return { status: "success", message: "Success Update Category" }
        else
          return { status: "failed", message: category.errors.to_s }
        end
      else
        return { status: "failed", message: "Category not found" }
      end
    rescue Exception => e
      return { status: "failed", message: e.message }
    end
  end

  def delete_article(params, current_user)
    begin
      category = Category.find(params[:id])
      if category.present?
        if category.update_attributes({ is_active: false, moderated_by: current_user.id.to_s })
          return { status: "success", message: "Success delete Category" }
        else
          return { status: "failed", message: category.errors.to_s }
        end
      else
        return { status: "failed", message: "Category not found" }
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
    elsif type_search == "title"
      search_query[:name] = query
    elsif type_search == "status"
      search_query[:is_publish] = query
    end
    return search_query
  end
end
