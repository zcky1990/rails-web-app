class Admin::WebMetaDataService
  def get_web_meta_data
    data = WebMeta.where({}).first
    if data.present?
        result = get_data(data).to_json 
    else
        result={}
    end
end

private
    def get_data(web_data)
        data = {
            id: web_data.id.to_s,
            title: web_data.title, 
            description: web_data.description,
            keywords: web_data.keywords,
            image_url: web_data.image_url,
            icon_image_url: web_data.icon_image_url
        }
        return data
    end
end
