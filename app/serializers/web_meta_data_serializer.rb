class WebMetaDataSerializer < ActiveModel::Serializer
  
  attribute :id 
  attributes :title, :description, :keywords, :image_url, :icon_image_url

  def id
    object.id.to_s
  end
end
