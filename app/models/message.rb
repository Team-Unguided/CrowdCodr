class Message < ActiveRecord::Base
    belongs_to :conversation
    belongs_to :user
    validates_presence_of :body, :conversation_id, :user_id
    validates :body, presence: true, allow_nil: false
 
    def message_time
        created_at.strftime("%m/%d/%y at %l:%M %p")
    end
end
