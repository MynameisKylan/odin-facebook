class CommentsController < ApplicationController
  def create
    @comment = current_user.comments.build(comment_params)

    if @comment.save
      flash.notice = 'Comment successfully posted'
      redirect_to @comment.post
    else
      flash.notice = 'Comment could not be saved'
      redirect_to posts_path
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :post_id)
  end
end
