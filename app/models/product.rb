class Product
    include Mongoid::Document
    include Mongoid::Timestamps
  
    store_in collection: 'products'
  
    field :name, type: String
    field :stock, type: Integer
    field :is_active, type: Boolean

    embeds_one :product_category, :class_name => "ProductCategory", inverse_of: :product
    embeds_many :price, :class_name => "Price"
    embeds_many :available_add_on, :class_name => "AvailableAddOn"
    belongs_to :created_by, :class_name => "User", optional: true
    belongs_to :moderated_by, :class_name => "User", optional: true

    index({ name: 1})
    index({ is_active: 1})
    index({ name:1, is_active: 1})

    def self.find_by_name(name)
      results = self.find_by(name: name)
      return results
    end
  
    
  
  end