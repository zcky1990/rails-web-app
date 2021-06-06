class Price
    include Mongoid::Document
    include Mongoid::Timestamps
    
    field :price, type: String
    has_one :price_type, :class_name => "PriceType"   

  end