class FriendRequestValidator < ActiveModel::Validator
  def validate(request)
    user1 = request.from_id
    user2 = request.recipient_id
    unless FriendRequest.where(from_id: user1, recipient_id: user2).or(FriendRequest.where(from_id: user2, recipient_id: user1)).empty?
      request.errors[:exists] << 'Friend request already exists!'
    end
  end
end