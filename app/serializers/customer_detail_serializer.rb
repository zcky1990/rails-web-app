class CustomerDetailSerializer < ActiveModel::Serializer
  attribute :id
  attribute :firstname
  attribute :lastname
  attribute :phone
  attribute :address
  attribute :email
  attribute :current_point
  attribute :used_point
  attribute :join_date
  attribute :is_active

  attribute :moderated_by
  attribute :updated_at

  def id
    object.id.to_s
  end

  def used_point
    object.used_point
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
