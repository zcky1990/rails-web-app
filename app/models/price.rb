class Price
    include Mongoid::Document
    include Mongoid::Timestamps
    
    field :price, type: String
    belongs_to :price_type, :class_name => "PriceType"   

  end