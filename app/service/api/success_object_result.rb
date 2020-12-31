class Api::SuccessObjectResult
  attr_reader :status,
              :data,
              :message
  SUCCESS = "success"
  ERROR = "error"

  def initialize(data:, message: nil)
    @status = SUCCESS
    @data = data
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
