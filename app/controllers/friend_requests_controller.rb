class FriendRequestsController < ApplicationController
  def index
    incoming_users_ids = current_user.incoming_friend_requests.pluck(:from_id)
    incoming_requests_ids = current_user.incoming_friend_requests.pluck(:id).sort
    @incoming_requests_users = User.where(id: incoming_users_ids).order(:id).zip(incoming_requests_ids)

    outgoing_request_ids = current_user.outgoing_friend_requests.pluck(:recipient_id)
    @outgoing_requests_users = User.where(id: outgoing_request_ids)
  end

  def create
    recipient = User.find(params[:recipient_id])
    request = recipient.incoming_friend_requests.build(from_id: current_user.id)

    if request.save
      flash.notice = 'Friend Request Sent'
    else
      flash.notice = "A request between you and #{recipient.first_name} already exists."
    end
    redirect_to user_path(recipient)
  end

  def destroy
    request = FriendRequest.find(params[:id])
    request.destroy
    flash.notice = 'Request Deleted'
    redirect_to friend_requests_path
  end
end
