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

  end
end
