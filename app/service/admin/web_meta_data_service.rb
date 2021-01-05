class Admin::WebMetaDataService
  def get_web_meta_data
    data = WebMeta.where({}).first
    if data.present?
      result = WebMetaDataSerializer.new(data).as_json
      set_redis("web_meta_data", result)
      return result
    else
      result = {}
    end
  end

  private

  def set_redis(key, json)
    $redis.set(key, json)
  end
end
