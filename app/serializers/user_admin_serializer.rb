class UserAdminSerializer < ActiveModel::Serializer
  
  attribute :id 
  attributes :email, :first_name, :last_name, :role

  def id
    object.id.to_s
  end
end
