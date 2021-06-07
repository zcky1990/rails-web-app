class SearchCategorySerializer < ActiveModel::Serializer
  attribute :product_category_id
  attribute :product_category_name
  attribute :desc
  attribute :status

  def product_category_id
    object.id.to_s
  end

  def product_category_name
    object.name
  end
end
