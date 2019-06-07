class User < ApplicationRecord
  before_save { self.email = email.first.downcase + email[1..-1] }
  before_create { generate_token(:auth_token) }

  def send_password_reset
    generate_token(:password_reset_token)
    self.password_reset_sent_at = Time.zone.now
    save!
    UserMailer.password_reset(self).deliver_now
  end

  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while User.exists?(column => self[column])
  end
  
  #  PASSWORD_VALIDATOR = /(      # Start of group
  #         (?:                        # Start of nonmatching group, 4 possible solutions
  #           (?=.*[a-z])              # Must contain one lowercase character
  #           (?=.*[A-Z])              # Must contain one uppercase character
  #           (?=.*\W)                 # Must contain one non-word character or symbol
  #         |                          # or...
  #           (?=.*\d)                 # Must contain one digit from 0-9
  #           (?=.*[A-Z])              # Must contain one uppercase character
  #           (?=.*\W)                 # Must contain one non-word character or symbol
  #         |                          # or...
  #           (?=.*\d)                 # Must contain one digit from 0-9
  #           (?=.*[a-z])              # Must contain one lowercase character
  #           (?=.*\W)                 # Must contain one non-word character or symbol
  #         |                          # or...
  #           (?=.*\d)                 # Must contain one digit from 0-9
  #           (?=.*[a-z])              # Must contain one lowercase character
  #           (?=.*[A-Z])              # Must contain one uppercase character
  #         )                          # End of nonmatching group with possible solutions
  #         .*                         # Match anything with previous condition checking
  # )/x 
  #   validates :password_confirmation, :password, :email, presence: true
  #   validates :email, length: { maximum: 255 }, uniqueness: { case_sensitive: false }
  #   validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  
  #   validates :password, {confirmation: true, length: { minimum: 8 }, format: {
  #                           with: PASSWORD_VALIDATOR,
  #                           message: "must contain 3 of the following 4: a lowercase letter, an uppercase letter, a digit, a non-word character or symbol"
  #                         }}
  validates :password, confirmation: true
  has_secure_password
  has_many :courses, dependent: :destroy
  has_many :read_aloud_charts, dependent: :destroy
end
