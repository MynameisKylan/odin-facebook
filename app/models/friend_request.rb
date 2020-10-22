class FriendRequest < ApplicationRecord
  belongs_to :recipient, class_name: 'User'
  belongs_to :from_user, class_name: 'User', foreign_key: 'from_id'
end
