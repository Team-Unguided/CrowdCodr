class Listing < ActiveRecord::Base

    validates :name, :description, :job_type, :languages, presence: true
    
    #Listing association to User
    belongs_to :user
    
    after_save :reindex_users
    before_destroy :reindex_users
    
    def reindex_users
        Sunspot.index(user)
    end
    
    #searching
    searchable do
       text :name
       text :description, :job_type, :languages 
    end
    
end
