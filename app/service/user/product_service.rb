class User::ProductService
  def get_all_product_list
    begin
      category_data = Category.where({is_active: true})
      category_datas = ActiveModel::Serializer::CollectionSerializer.new(category_data, serializer: CategorySerializer)

      product_data = Product.where({is_active: true}).order_by(updated_at: :desc)
      product_datas = ActiveModel::Serializer::CollectionSerializer.new(product_data, serializer: ProductSerializer)
      response = {
        "category": category_datas,
        "product": product_datas
      }
      return response
    rescue Exception => e
      return []
    end
  end
end
