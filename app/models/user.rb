class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable
  has_many :pictures
  has_many :likes
  has_many :liked_pictures, :through => :likes, :source => :picture
  has_many :votes
  has_many :voted_pictures, :through => :votes, :source => :picture
  has_many :viewed_photos
  has_many :viewed_pictures, :through => :viewed_photos, :source => :picture

  def liked
    likes.where(like_object: true)
  end

  def disliked
    likes.where(like_object: false)
  end

  def activity_feed
    pictures.joins(:votes, :voted_users).select('pictures.file, users.email, votes.created_at')
  end
end
