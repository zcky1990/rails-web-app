class AvailableAddOn
    include Mongoid::Document
    include Mongoid::Timestamps
    
    embeds_one :add_on, :class_name => "AddOn"   
  end