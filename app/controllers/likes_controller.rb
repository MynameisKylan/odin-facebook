class LikesController < ApplicationController
  def create
    @like = current_user.likes.build(like_params)

    if @like.save
      flash.notice = 'You liked that post'
    else
      flash.alert = 'You\'ve already liked that'
    end
    redirect_to posts_path
  end

  def destroy
    @like = Like.find(params[:id])

    @like.destroy
    flash.notice = 'You unliked that post'
    redirect_to posts_path
  end

  private

  def like_params
    params.permit(:post_id)
  end
end
