class User < ApplicationRecord
  after_create :create_default_profile
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  has_many :friend_requests, dependent: :destroy
  has_many :pending_friends, through: :friend_requests, source: :friend

  has_many :friendships, dependent: :destroy
  has_many :friends, through: :friendships

  has_many :posts, dependent: :destroy

  has_many :likes
  has_many :comments

  has_one :profile, dependent: :destroy

  def create_default_profile
    create_profile(name: email, description: "Nothing here yet!")
  end

  def remove_friend(friend)
    current_user.friends.destroy(friend)
  end

  def name
    if profile
      profile.name || email
    else
      email
    end
  end
  
  def is_friends_with?(friend)
    pending_friends.include?(friend)
  end
end
