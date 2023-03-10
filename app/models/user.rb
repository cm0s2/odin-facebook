class User < ApplicationRecord
  after_create :create_default_profile
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:github]
  
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

  def is_friend_or_pending_friend(user)
    pending_friends.include?(user) || friends.include?(user) || self == user
  end
  
  def is_friends_with?(friend)
    pending_friends.include?(friend)
  end

  def self.from_omniauth(access_token)
    data = access_token.info
    puts data
    user = User.where(email: data['email']).first

    # Uncomment the section below if you want users to be created if they don't exist
    unless user
        user = User.create(
           email: data['email'],
           password: Devise.friendly_token[0,20]
        )
    end
    user
end
end
