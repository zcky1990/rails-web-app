class AccessLevel
  include Mongoid::Document
  include Mongoid::Timestamps

  embedded_in :user
  field :level, type: Integer
end
