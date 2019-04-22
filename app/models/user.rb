class User < ApplicationRecord
  before_save { self.email = email.downcase }
  
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

end
