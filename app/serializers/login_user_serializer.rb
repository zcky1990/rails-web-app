class LoginUserSerializer < ActiveModel::Serializer
  
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
  attribute :token


  def id
    object.id.to_s
  end

  def birthday
    object.birthday.strftime("%d/%m/%Y")
  end

  def token
    token = JsonWebToken.encode(user_id: object.id.to_s)
  end

end
