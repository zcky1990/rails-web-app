class UserSerializer < ActiveModel::Serializer
  
  attribute :id 
  attribute :email
  attribute :first_name
  attribute :last_name
  attribute :birthday 
  attribute :address
  attribute :postal_code
  attribute :gender
  attribute :phone_number
  attribute :description


  def id
    object.id.to_s
  end

  def birthday
    object.birthday.strftime("%d/%m/%Y")
  end

end
