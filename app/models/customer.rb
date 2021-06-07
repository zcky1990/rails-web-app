class Customer
  include Mongoid::Document
  include Mongoid::Timestamps

  store_in collection: "customers"

  field :name, type: String
  field :phone, type: String
  field :address, type: String
  field :email, type: String
  field :current_point, type: Integer
  field :used_point, type: Integer

  belongs_to :created_by, :class_name => "User", optional: true
  belongs_to :moderated_by, :class_name => "User", optional: true

  index({ name: 1 })
  index({ phone: 1 })

  def self.find_by_name(name)
    results = self.find_by(name: name)
    return results
  end

  def self.find_by_phone(phone)
    results = self.find_by(phone: phone)
    return results
  end

end
