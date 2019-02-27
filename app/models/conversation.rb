class Conversation < ActiveRecord::Base
  belongs_to :sender, :foreign_key => :sender_id, class_name: "User"
  belongs_to :recipient, :foreign_key => :recipient_id, class_name: "User"
  has_many :messages, dependent: :destroy
  validates_uniqueness_of :sender_id, :scope => :recipient_id

  scope :between, -> (sender_id,recipient_id) do
    hash = {}
    conversation = where("(conversations.sender_id = ? AND conversations.recipient_id =?) OR (conversations.sender_id = ? AND conversations.recipient_id =?)", sender_id, recipient_id, recipient_id, sender_id).last
    if conversation.present?
      hash[:sender] = conversation.sender
      hash[:recipient] = conversation.recipient
      hash[:messages] = conversation.messages.map {|x| {body: x.body, user: x.user[:email]}}
    end
    hash
  end

  scope :find_json, -> (sender_id) do
    conversations = select {|x| x.sender_id == sender_id.to_i || x.recipient_id == sender_id.to_i}
    conversations.map {|x| {sender: x.sender,
                            recipient: x.recipient,
                            url: "/conversations/#{x.id}",
                            message_count: x.messages.where(read: false).count
                          }
                      }
  end

  def find_messages
    {
      sender: sender.email,
      recipient: recipient.email,
      messages: messages.map {|x| {user: x.user.email, body: x.body, time: x.created_at}},
      message_count: messages.where(read: false).count
    }
  end
end
