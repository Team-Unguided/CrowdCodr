class User < ActiveRecord::Base
  #Connects listing to Users, stating that user may have many listings
  #Deletes all the User's listings when User is deleted
  has_many :listings, dependent: :destroy
  has_many :projects, dependent: :destroy
  #######following ########
  has_many :active_relationships, class_name: "Relationship",
      foreign_key: "follower_id",
      dependent: :destroy
  has_many :passive_relationships, class_name:  "Relationship",
                                   foreign_key: "followed_id",
                                   dependent:   :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower
  ########### Review ##########
  #this would be the person the reviews are about
  has_many :reviews, dependent: :destroy
  #this would be the person writing the reviews
  has_many :judgements, :through => :reviews
  # downcase email before adding User to database to avoid uniqueness errors
  before_save { self.email = email.downcase }
  
  # use app/models/uploaders/picture_uploader.rb
  # to upload pictures associated with :picture
  mount_uploader :picture, PictureUploader
  
  
  
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
  
  # password cannot be empty or shorter than 6 characters
  # ("allow_nil: true" lets users edit their info without changing password)
  # (still does not allow empty password for signup due to "has_secure_password")
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true
  
  VALID_ZIP_REGEX = /[0-9][0-9][0-9][0-9][0-9]/i
  validates :zipcode, format: { with: VALID_ZIP_REGEX }, allow_nil: true
  
  validate  :picture_size
  
  
  
  # Class method for User class
  
  # Returns the hash digest of the given string.
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end
  
  # Class method for User
  # Searches first_name, last_name and user_name text fields
  #SEARCH
  searchable :auto_index => true, :auto_remove => true do
    text :first_name
    text :last_name
    text :username
    integer :zipcode
    
    # associate fields from listings
    text :name do
      listings.map { |listing| listing.name}
    end
    text :description do
      listings.map { |listing| listing.description}
    end
    text :job_type do
      listings.map { |listing| listing.job_type}
    end
    text :languages do
      listings.map { |listing| listing.languages}
    end

    # average review score for sort
    float :avg_review do
      if reviews.blank?
        avg_review = 0
      else
        avg_review = reviews.average(:rating).round(2)
      end
    end
    
    #review count
    integer :review_count do
      reiew_count = reviews.count
    end
    
  end
  def follow(other_user)
    active_relationships.create(followed_id: other_user.id)
  end

  # Unfollows a user.
  def unfollow(other_user)
    active_relationships.find_by(followed_id: other_user.id).destroy
  end

  # Returns true if the current user is following the other user.
  def following?(other_user)
    following.include?(other_user)
  end
  #User association to Listings. Destroy listing if user is deleted.
  has_many :listings, dependent: :destroy
  has_many :sales, class_name: "Order", foreign_key: "seller_id"
  has_many :purchases, class_name: "Order", foreign_key: "buyer_id"
  
  private

    # Validates the size of an uploaded picture.
    def picture_size
      if picture.size > 5.megabytes
        errors.add(:picture, "Profile pic cannot be more than 5MB in size")
      end
    end
end
