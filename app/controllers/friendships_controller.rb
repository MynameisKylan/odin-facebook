class FriendshipsController < ApplicationController
  def create
    recipient = User.find(params[:recipient_id])
    @friendship_1 = current_user.friendships.build(friend_id: params[:recipient_id])
    @friendship_2 = recipient.friendships.build(friend_id: current_user.id)

    if @friendship_1.save && @friendship_2.save
      flash.notice = "You are now friends with #{recipient.first_name}"
      FriendRequest.delete(params[:request_id])
    else
      flash.notice = 'Could not accept friend request. Please try again'
    end
    redirect_to friend_requests_path
  end

  def destroy
    friendship_1 = Friendship.find_by(user_id: params[:user_id], friend_id: params[:friend_id])
    friendship_2 = Friendship.find_by(user_id: params[:friend_id], friend_id: params[:user_id])

    friendship_1.destroy
    friendship_2.destroy

    flash.notice = "You are no longer friends with #{User.find(params[:friend_id]).first_name}."

    redirect_back(fallback_location: root_path)
  end
end
