class Product
    include Mongoid::Document
    include Mongoid::Timestamps
  
    store_in collection: 'products'
  
    field :name, type: String
    field :stock, type: Integer
    field :price, type: Integer

    has_one :product_category, class_name: "Category"
    belongs_to :created_by, :class_name => "User", optional: true
    belongs_to :moderated_by, :class_name => "User", optional: true

    index({ name: 1})

    def self.find_by_name(name)
      results = self.find_by(name: name)
      return results
    end
  
    
  
  end