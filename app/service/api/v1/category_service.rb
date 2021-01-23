class Api::V1::CategoryService < Api::V1::JsonService
  def search_category(params)
    begin
      query = "^" + params[:query]
      data = Category.where({ name: { "$regex": query, "$options": "i" } }).hint({ name: 1 })
      datas = ActiveModel::Serializer::CollectionSerializer.new(data, serializer: SearchCategorySerializer)
      return Api::SuccessListResult.new(data: datas, message: "success get category list")
    rescue Exception => e
      return Api::ErrorResult.new(error_code: 500, error_title: "Error get category list", error_message: e.message)
    end
  end
end
