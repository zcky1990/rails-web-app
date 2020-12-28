class Api::Admin::WebMetaDataService
  def get_web_meta_data
    data = WebMeta.where({}).first
    if data.present?
        result = get_data(data).to_json 
    else
        result={}
    end
end

def upload_image(imageFile, folder)
    fileName = imageFile.headers['filename']
    imageResponse = Cloudinary::Uploader.upload_large(imageFile.open, :public_id => fileName, :folder => folder, :overwrite => true)
    if imageResponse['secure_url'].present?
        data = {
            secure_url: imageResponse['secure_url']
        }
        create_success_result_json("success", data)
    else
        create_error_result_json("failed", "failed to upload image")
    end
end

def web_meta_data(params)
    web_meta = WebMeta.search_meta_data_by_id(params[:id])
    if web_meta.present?
        web_meta.update_attributes(title: params[:title])
        web_meta.update_attributes(description: params[:description])
        web_meta.update_attributes(keywords: params[:keywords])
        web_meta.update_attributes(image_url: params[:image_url])
        web_meta.update_attributes(icon_image_url: params[:icon_image_url])
        if web_meta.save
            data = get_data(web_meta)
            create_success_result_json("success", data)
        else
            create_error_result_json("failed", "failed to update data: #{web_meta.errors}")
        end
    else
        data = {
            title: params[:title], 
            description: params[:description],
            keywords: params[:keywords],
            image_url: params[:image_url],
            icon_image_url: params[:icon_image_url]
        }
       web_data =  WebMeta.new(data)
        if web_data.save
            data = get_data(web_data)
            create_success_result_json("success", data)
        else
            create_error_result_json("failed", "failed to save data: #{web_data.errors}")
        end
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

def create_success_result_json(status, data)
  result = {
    status: status,
    status_code: 200,
  }
  result[:data] = data
  return result
end

def create_error_result_json(status, message_data)
    result = {
      status: status,
      data: { 
        message: message_data
     }
    }
    return result
end

end
