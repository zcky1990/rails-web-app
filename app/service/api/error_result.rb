class Api::ErrorResult
  attr_reader :status,
              :error_code,
              :error_title,
              :error_message
  ERROR = "error"

  def initialize(error_code:, error_title: nil, error_message:)
    @status = ERROR
    @error_code = error_code
    @error_title = error_title
    @error_message = validate(error_message)
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
