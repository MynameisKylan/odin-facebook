require 'rails_helper'
require './spec/support/helpers'

RSpec.describe "Comments", type: :system do
  before do
    driven_by(:rack_test)
    @user = create(:user, first_name: 'whatever', last_name: 'something', email: 'fake@mail.com', password: 'password')
    login
  end

  describe 'Comment creation' do
    it 'comment is created and displayed beneath a post' do
      post = create(:post, user_id: @user.id, content: 'this is a text post')
      visit '/'
      expect(page).to have_content('this is a text post')
      visit '/'
      expect(page).to have_content('New Post')
      fill_in 'Write a Comment...', with: 'this is a comment'
      click_on 'Post'
      expect(page).to have_content('Comment successfully posted')
      expect(current_path).to eq("/posts/#{post.id}")
      expect(page).to have_content('this is a comment')
    end
  end
end
