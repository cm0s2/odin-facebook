class FriendRequest < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: 'User'

  validates :user_id, uniqueness: { scope: :friend_id, message: "A friend request is already pending"}

  def accept
    user.friends << friend
    destroy
  end
end
