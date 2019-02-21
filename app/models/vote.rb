class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :picture

  after_create :viewed_photo

  def viewed_photo
    ViewedPhoto.create(user_id: user.id, picture_id: picture.id)
  end
end
