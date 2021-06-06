class PriceTypeSerializer < ActiveModel::Serializer
  attribute :id
  attribute :name
  attribute :desc
  attribute :is_active

  attribute :moderated_by
  attribute :updated_at

  def id
    object.id.to_s
  end

  def moderated_by
    object.moderated_by.first_name + " " + object.moderated_by.last_name
  end

  def updated_at
    object.updated_at.strftime("%d/%m/%Y")
  end
end
