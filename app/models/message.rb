class Message < ActiveRecord::Base
  belongs_to :conversation, optional: true
  belongs_to :user
  validates_presence_of :body, :conversation_id, :user_id

  before_create :update_read_messages

  def update_read_messages
    if !conversation.messages.empty?
      last_message = self.conversation.messages.last
      last_message.update_attribute(:read, true)
    end
  end

  def message_time
    created_at.strftime("%m/%d/%y at %l:%M %p")
  end
end
