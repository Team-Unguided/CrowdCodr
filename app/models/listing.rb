class Listing < ActiveRecord::Base

    validates :name, :description, :job_type, :languages, presence: true
    
    #Listing association to User
    belongs_to :user
    
    #searching
    searchable do
       text :name, :boost => 2
       text :description, :job_type, :languages 
    end
    
end
