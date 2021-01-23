class CategorySerializer < ActiveModel::Serializer
  attribute :id
  attribute :name
  attribute :desc
  attribute :status

  attribute :moderated_by

  def id
    object.id.to_s
  end

  def moderated_by
    object.moderated_by.first_name + " " + object.moderated_by.last_name
  end
end
