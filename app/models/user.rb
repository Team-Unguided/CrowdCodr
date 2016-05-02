class User < ActiveRecord::Base
  #Connects listing to Users, stating that user may have many listings
  #Deletes all the User's listings when User is deleted
  has_many :listing, dependent: :destroy
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
  
  # Class method for User class
  # Returns the hash digest of the given string.
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end
  
  # Class method for User
  # Searches first_name, last_name and user_name text fields
  def self.search(search)
    User.where('first_name LIKE :search OR last_name LIKE :search OR username LIKE :search', search: "%#{search}%")
  end
  
  #User association to Listings. Destroy listing if user is deleted.
  has_many :listings, dependent: :destroy
end
