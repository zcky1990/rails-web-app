class Category
  include Mongoid::Document
  include Mongoid::Timestamps

  store_in collection: "categories"

  field :name, type: String
  field :desc, type: String
  field :status, type: Boolean
  field :is_active, type: Boolean, default: true

  belongs_to :created_by, :class_name => "User", optional: true
  belongs_to :moderated_by, :class_name => "User", optional: true

  index({ name: 1 },{ unique: true })
  index({ is_active: 1 })

  def self.find_by_name(name)
    results = self.find_by(name: name)
    return results
  end

  def get_data_category
    data = {
      name: self.name,
      desc: self.desc,
      status: self.status,
      is_active: self.is_active
    }
  end
end
