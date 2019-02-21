class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable
  has_many :pictures
  has_many :likes
  has_many :liked_pictures, :through => :likes, :source => :picture
  has_many :votes
  has_many :voted_pictures, :through => :votes, :source => :picture

  def liked
    likes.where(like_object: true)
  end

  def disliked
    likes.where(like_object: false)
  end

  def self.all_except(current_user, photo_user)
    where.not(id: [current_user, photo_user]).joins(:pictures).sample
  end
end
