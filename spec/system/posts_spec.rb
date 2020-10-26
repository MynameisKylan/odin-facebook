require 'rails_helper'
require './spec/support/helpers'

RSpec.describe "Posts", type: :system do
  before do
    driven_by(:rack_test)
    create(:user, first_name: 'whatever', last_name: 'something', email: 'fake@mail.com', password: 'password')
    login
  end

  describe 'Post creation' do
    it 'creates new text post' do
      click_on 'New Post'
      expect(page).to have_content('New Post')
      fill_in 'Content', with: 'text for new post'
      click_on 'Create Post'
      expect(page).to have_content('Post was successfully created')
      expect(page).to have_content('text for new post')
    end
  end
end

private

def login
  visit '/users/sign_in'
  fill_in 'Email', with: 'fake@mail.com'
  fill_in 'Password', with: 'password'
  click_on 'Log in'
end
