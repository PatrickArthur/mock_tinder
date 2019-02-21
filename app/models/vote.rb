class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :picture

  after_create :viewed_photo

  def viewed_photo
    picture.update_attribute(:viewed_at, Time.now)
  end
end
