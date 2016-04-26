class User < ActiveRecord::Base
  # downcase email before adding User to database to avoid uniqueness errors
  before_save { self.email = email.downcase }
  
  # VALIDATIONS
  
  # first_name cannot be empty or longer than 75 chars
  validates(:first_name, presence: true, length: { maximum: 75 })  # same as next line format-wise
  # last_name cannot be empty or longer than 75 chars
  validates :last_name, presence: true, length: { maximum: 75 }    # parentheses may be omitted
  
  # username cannot be empty or longer than 25 chars. It must be unique. 
  validates :username, presence: true, length: { maximum: 25 }, uniqueness: true
  
  # email cannot be empty or longer than 255 chars. It must be unique & valid format.
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                              format: { with: VALID_EMAIL_REGEX },
                              uniqueness: { case_sensitive: false }
  # adds Rails built-in secure password 
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }
end
