class Post < ApplicationRecord
  belongs_to :user

  has_many :likes, as: :likeable
  has_many :comments, as: :commentable

  scope :posts_by_user, ->(user) { where(user: user)}
  scope :posts_by_friends, ->(user) { where(user: user.friends )}

  scope :timeline_for, ->(user) { posts_by_user(user).or(posts_by_friends(user)) }
end
