class ProductCategory
  include Mongoid::Document

  embeds_one :category, :class_name => "Category"   

end
