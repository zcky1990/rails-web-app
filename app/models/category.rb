class Category
  include Mongoid::Document
  include Mongoid::Timestamps

  store_in collection: "categories"

  field :name, type: String
  field :desc, type: String
  field :status, type: Boolean
  field :is_active, type: Boolean, default: true

  index({ name: 1 })
  index({ is_active: 1 })

  def self.find_by_name(name)
    results = self.find_by(name: name)
    return results
  end
end
