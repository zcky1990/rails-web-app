class Api::SuccessListResult
  attr_reader :status,
              :total_data,
              :total_page,
              :data,
              :message
  SUCCESS = "success"
  ERROR = "error"

  def initialize(data:, message: nil, total_data:, total_page:)
    @status = SUCCESS
    @data = data
    @total_data = total_data
    @total_page = total_page
    @message = validate(message)
  end

  private

  def validate(message)
    case message
    when String
      message
    when Hash
      message.values.join(", ")
    when ActiveModel::Errors
      message.full_messages.join(", ")
    else
      raise "Unsupported Parameter Type"
    end
  end
end
