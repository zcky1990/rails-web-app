class WebMeta
    include Mongoid::Document
    include Mongoid::Timestamps
  
    store_in collection: 'web_meta'
  
    field :title, type: String
    field :description, type: String
    field :icon_image_url, type: String
    field :image_url, type: String
    field :keywords, type: String
  
    index({ title: 1})
  
    def self.search_meta_data_by_title(title)
      self.find_by(title: title)
    end
  
    def self.search_meta_data_by_id(id)
      self.find_by(id: id)
    end
  
  end