class CustomerSerializer < ActiveModel::Serializer
  attribute :id
  attribute :firstname
  attribute :lastname
  attribute :phone
  attribute :address
  attribute :email
  attribute :current_point
  attribute :join_date

  attribute :moderated_by
  attribute :updated_at

  def id
    object.id.to_s
  end

  def moderated_by
    object.moderated_by.first_name + " " + object.moderated_by.last_name
  end

  def join_date
    object.join_date.strftime("%d/%m/%Y")
  end

  def updated_at
    object.updated_at.strftime("%d/%m/%Y")
  end
end
