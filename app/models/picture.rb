class Picture < ApplicationRecord
  mount_uploader :file, PhotoUploader
  belongs_to :user, optional: true
  has_many :likes
  has_many :liked_users, :through => :likes, :source => :user
  has_many :votes
  has_many :voted_users, :through => :votes, :source => :user
  has_many :viewed_photos
  has_many :viewed_photos_users, :through => :viewed_photos, :source => :user
  validates :file, presence: true

  def self.get_picture(user)
    where.not(id: user.viewed_pictures).sample
  end
end
