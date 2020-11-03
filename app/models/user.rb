class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 20 }

  has_many :posts
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :friendships
  has_many :friendship_requests, class_name: "Friendship", foreign_key: "friend_id"
  def friends
    friends_array = friendships.map{|friendship| friendship.friend if friendship.confirmed} 
    friends_array.compact
  end
  def pending_friends
    friendships.map{|friendship| friendship.friend if !friendship.confirmed}.compact
  end
  def friend_requests
    friendship_requests.map{|friendship| friendship.user if !friendship.confirmed}.compact
  end
  def friend?(user)
    friends.include?(user)
  end
end
