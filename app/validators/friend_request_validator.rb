class FriendRequestValidator < ActiveModel::Validator
  def validate(request)
    user1 = request.from_id
    user2 = request.recipient_id

    if !FriendRequest.where(from_id: user1, recipient_id: user2).or(FriendRequest.where(from_id: user2, recipient_id: user1)).empty?
      request.errors[:exists] << 'Friend request already exists!'
    elsif User.find(user1).friends.find_by('user_id=?', user2)
      request.errors[:friends] << 'You are already friends.'
    end
  end
end