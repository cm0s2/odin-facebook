class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  has_many :friend_requests, dependent: :destroy
  has_many :pending_friends, through: :friend_requests, source: :friend

  has_many :friendships, dependent: :destroy
  has_many :friends, through: :friendships

  def remove_friend(friend)
    current_user.friends.destroy(friend)
  end

  # TODO: Lägg till metod för att kolla om man är vän
  def name
    email
  end
  
  def is_friends_with?(friend)
    pending_friends.include?(friend)
  end
end
