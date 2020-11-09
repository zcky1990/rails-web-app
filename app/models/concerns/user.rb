class User
  include Mongoid::Document
  include Mongoid::Timestamps

  store_in collection: 'users'

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable

  field :email,              type: String, default: ""
  field :encrypted_password, type: String, default: ""
  field :first_name,              type: String
  field :last_name,              type: String
  field :birthday,              type: Date
  field :address,              type: String

  ## Recoverable
  field :reset_password_token,   type: String
  field :reset_password_sent_at, type: Time

  ## Rememberable
  field :remember_created_at, type: Time

  ## Trackable
  # field :sign_in_count,      type: Integer, default: 0
  # field :current_sign_in_at, type: Time
  # field :last_sign_in_at,    type: Time
  # field :current_sign_in_ip, type: String
  # field :last_sign_in_ip,    type: String

  ## Confirmable
  # field :confirmation_token,   type: String
  # field :confirmed_at,         type: Time
  # field :confirmation_sent_at, type: Time
  # field :unconfirmed_email,    type: String # Only if using reconfirmable

  ## Lockable
  # field :failed_attempts, type: Integer, default: 0 # Only if lock strategy is :failed_attempts
  # field :unlock_token,    type: String # Only if unlock strategy is :email or :both
  # field :locked_at,       type: Time
  
  index({email: 1})

  def self.find_by_email(email)
    results = self.find_by(email: email)
    return  results
  end

  def will_save_change_to_email?
    false
  end
end
