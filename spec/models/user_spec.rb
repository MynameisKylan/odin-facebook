require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = create(:user)
    @post = create(:post, user_id: @user.id)
    @comment = create(:comment, user_id: @user.id, post_id: @post.id)
    @like = create(:like, user_id: @user.id, post_id: @post.id)
    @user2 = create(:user, email: 'fake@mail.com')
    @req = create(:friend_request, from_id: @user.id, recipient_id: @user2.id)
  end

  describe 'associations' do
    it 'can access its posts' do
      expect(@user.posts.to_a).to eql([@post])
    end

    it 'can access its comments' do
      expect(@user.comments.to_a).to eql([@comment])
    end

    it 'can access its friends' do
      create(:friendship, user_id: @user.id, friend_id: @user2.id)
      create(:friendship, user_id: @user2.id, friend_id: @user.id)
      expect(@user.friends.to_a).to eql([@user2])
      expect(@user2.friends.to_a).to eql([@user])
    end

    it 'can access its likes' do
      expect(@user.likes.to_a).to eql([@like])
    end

    it 'can access liked posts' do
      expect(@user.liked_posts.to_a).to eql([@post])
    end

    it 'can access incoming friend requests' do
      expect(@user2.incoming_friend_requests.to_a).to eql([@req])
    end

    it 'can access outgoing friend requests' do
      expect(@user.outgoing_friend_requests.to_a).to eql([@req])
    end
  end
end
