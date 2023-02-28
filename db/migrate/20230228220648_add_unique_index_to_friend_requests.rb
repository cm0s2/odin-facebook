class AddUniqueIndexToFriendRequests < ActiveRecord::Migration[7.0]
  def change
    add_index :friend_requests, [:user_id, :friend_id], unique: true
  end
end
