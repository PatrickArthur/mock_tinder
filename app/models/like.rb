class Like < ApplicationRecord
  belongs_to :user
  belongs_to :picture

  after_create :viewed_photo_check_conversation

  def viewed_photo_check_conversation
    ViewedPhoto.create(user_id: user.id, picture_id: picture.id)
    if self.like_object
      Conversation.find_or_create_by(sender: user, recipient: picture.user)
    end
  end
end
