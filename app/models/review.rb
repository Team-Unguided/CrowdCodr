class Review < ActiveRecord::Base
  #this would be the person the reviews are about
  belongs_to :user #refers to user_id
  #this would be the person writing the reviews
  belongs_to :judgement, :class_name => 'User' #refers to subject_id
  
  default_scope -> { order(created_at: :desc) }
end