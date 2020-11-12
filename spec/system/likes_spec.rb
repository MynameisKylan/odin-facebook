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
      click_on 'Like'
      expect(page).to have_link('Unlike')
    end
  end

  describe 'unliking' do
    it 'can unlike' do
      visit '/'
      click_on 'Like'
      click_on 'Unlike'
      expect(page).to have_link('Like')
    end
  end
end
