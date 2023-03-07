class Comment < ApplicationRecord
  belongs_to :user, dependent: :destroy
  belongs_to :commentable, polymorphic: true

  validates :body, presence: true

  has_many :likes, as: :likeable
end
