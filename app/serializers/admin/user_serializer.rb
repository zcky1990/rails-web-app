class Admin::UserSerializer < ActiveModel::Serializer
  
  attribute :id 
  attributes :email, :first_name, :last_name, :birthday, :address, :postal_code, :gender, :phone_number, :description

  def id
    object.id.to_s
  end
end
