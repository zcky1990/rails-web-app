class PriceType
  include Mongoid::Document
  include Mongoid::Timestamps

  store_in collection: "price_types"

  field :name, type: String
  field :desc, type: String
  field :is_active, type: Boolean, default: false

  belongs_to :created_by, :class_name => "User", optional: true
  belongs_to :moderated_by, :class_name => "User", optional: true

  index({ name: 1 })

  def self.find_by_name(name)
    results = self.find_by(name: name)
    return results
  end
end
