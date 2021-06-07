class Customer
  include Mongoid::Document
  include Mongoid::Timestamps

  store_in collection: "customers"

  field :join_date, type: Date
  field :firstname, type: String
  field :lastname, type: String
  field :phone, type: String
  field :address, type: String
  field :email, type: String
  field :current_point, type: Integer, default: 0
  field :used_point, type: Integer, default: 0
  field :is_active, type: Boolean, default: false

  belongs_to :created_by, :class_name => "User", optional: true
  belongs_to :moderated_by, :class_name => "User", optional: true

  index({ phone: 1 })

  def self.find_by_phone(phone)
    results = self.find_by(phone: phone)
    return results
  end

end
