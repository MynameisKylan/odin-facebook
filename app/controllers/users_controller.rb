class UsersController < ApplicationController
  def index
    friend_ids = current_user.friends.pluck(:id) << current_user.id
    @users = User.where.not(id: friend_ids)
  end

  def show
    @user = User.includes(:posts).find(params[:id])
  end
end
