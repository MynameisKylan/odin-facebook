class UsersController < ApplicationController
  def index
    friend_ids = current_user.friends.pluck(:id) << current_user.id
    friend_or_pending_ids = friend_ids + current_user.outgoing_friend_requests.pluck(:recipient_id)
    @users = User.where.not(id: friend_or_pending_ids)
  end

  def show
    @user = User.includes(:posts).find(params[:id])
  end
end
