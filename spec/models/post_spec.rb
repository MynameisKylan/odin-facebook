require 'rails_helper'

RSpec.describe Post, type: :model do
  before do
    @user = create(:user)
    @post = create(:post, user_id: @user.id)
  end
  describe 'associations' do
    it 'can access user who created post' do
      expect(@post.user_id).to eql(@user.id)
    end

    it 'can access comments of post' do
      comment = create(:comment, post_id: @post.id, user_id: @user.id)
      expect(@post.comments.to_a).to eql([comment])
    end

    it 'can access its likes' do
      like = create(:like, user_id: @user.id, post_id: @post.id)
      expect(@post.likes.to_a).to eql([like])
    end
  end
end
