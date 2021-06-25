class User::ProductService
  def get_all_product_list
    begin
      data = Product.where({}).order_by(updated_at: :desc)
      datas = ActiveModel::Serializer::CollectionSerializer.new(data, serializer: ProductSerializer)
      return datas
    rescue Exception => e
      return []
    end
  end
end
