class AccessLevel
  include Mongoid::Document
  include Mongoid::Timestamps

  store_in collection: "user_access_level"

  embedded_in :user
  field :access_level, type: Integer

  index({ user_id: 1 })
  
  def self.find_by_user(user_id)
    results = self.where(user_id: user_id)
    return results
  end
end
