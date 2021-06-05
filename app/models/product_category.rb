class ProductCategory
  include Mongoid::Document

  field :name, type: String
  field :desc, type: String
  field :status, type: Boolean
  field :is_active, type: Boolean, default: true

end
