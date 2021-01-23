class SearchCategorySerializer < ActiveModel::Serializer
  attribute :id
  attribute :name
  attribute :desc
  attribute :status

  def id
    object.id.to_s
  end
end
