class Picture < ApplicationRecord
  mount_uploader :file, PhotoUploader
  belongs_to :user, optional: true
  has_many :likes
  has_many :liked_users, :through => :likes, :source => :user
  has_many :votes
  has_many :voted_users, :through => :votes, :source => :user
  validates :file, presence: true

  def self.get_picture(user)
    pictures = where.not(user_id: user.id)
    not_viewed = pictures.where(viewed_at: nil)
    not_viewed.sample
  end

  def self.votes_json
    array = []
    votes = all.map {|x| x.votes}.flatten
    votes.each do |vote|
      hash = {}
      hash[:picture] = vote.picture
      hash[:email] = vote.user.email
      hash[:time] = vote.created_at.strftime("%m/%d/%Y at %I:%M%p")
      array << hash
    end
    array.sort_by { |hsh| hsh[:time] }
  end
end
