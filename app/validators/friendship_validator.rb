class FriendshipValidator < ActiveModel::Validator
  def validate(friendship)
    user = User.find(friendship.user_id)
    friend = User.find(friendship.friend_id)
    if user.friends.find_by(id: friendship.friend_id)
      friendship.errors[:friends] << "You are already friends with #{friend.first_name}."
    end
  end
end