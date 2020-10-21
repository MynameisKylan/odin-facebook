class FriendRequestsController < ApplicationController
  def create
    recipient = User.find(params[:recipient_id])
    request = recipient.incoming_friend_requests.build(from_id: current_user.id)

    if request.save
      flash.notice = 'Friend Request Sent'
    else
      flash.notice = 'Could\'t Send Friend Request. Please try again'
    end
    redirect_to user_path(recipient)
  end

  def destroy
  
  end
end
