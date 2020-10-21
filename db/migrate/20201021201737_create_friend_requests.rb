class CreateFriendRequests < ActiveRecord::Migration[6.0]
  def change
    create_table :friend_requests do |t|
      t.integer :from_id
      t.integer :recipient_id

      t.timestamps
    end
  end
end
