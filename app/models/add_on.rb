class AddOn
  include Mongoid::Document
  include Mongoid::Timestamps

  store_in collection: "add_ons"

  field :name, type: String
  field :price, type: String
  field :is_active, type: Boolean, default: false

  belongs_to :created_by, :class_name => "User", optional: true
  belongs_to :moderated_by, :class_name => "User", optional: true

  index({ name: 1 },{ unique: true })
  index({ is_active: 1 })

  def self.find_by_name(name)
    results = self.find_by(name: name)
    return results
  end
end
