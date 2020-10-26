require 'rails_helper'
require './spec/support/helpers'

RSpec.describe "Likes", type: :system do
  before do
    driven_by(:rack_test)
    @user = create(:user, first_name: 'whatever', last_name: 'something', email: 'fake@mail.com', password: 'password')
    login
    create(:post, content: 'text post', user_id: @user.id)
  end

  describe 'liking' do
    it 'like will be displayed on post' do
      visit '/'
      click_button 'Like Post'
      expect(page).to have_content(@user.first_name + ' liked this')
    end
  end

  describe 'unliking' do
    it 'can unlike' do
      visit '/'
      click_button 'Like Post'
      click_on 'Unlike Post'
      expect(page).to have_button('Like Post')
    end
  end
end
