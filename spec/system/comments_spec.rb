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
      create(:post, user_id: @user.id, content: 'this is a text post')
      visit '/'
      expect(page).to have_content('this is a text post')
      visit '/'
      expect(page).to have_content('Posts')
      fill_in 'Post a Comment', with: 'this is a comment'
      click_on 'Post'
      expect(page).to have_content('Comment successfully posted')
      expect(page).to have_content(@user.first_name + ' ' + @user.last_name + ' said:')
      expect(page).to have_content('this is a comment')
    end
  end
end
