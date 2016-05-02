class Listing < ActiveRecord::Base

    validates :name, :description, :job_type, :languages, presence: true
    
    #Listing association to User
    belongs_to :user
end
