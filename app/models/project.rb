class Project < ActiveRecord::Base
    
    
    validates :name, :description, :job_type, :languages, presence: true
    
    belongs_to :user
end
