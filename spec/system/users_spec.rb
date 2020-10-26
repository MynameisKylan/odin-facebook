require 'rails_helper'
require './spec/support/helpers'

RSpec.describe "Users", type: :system do
  before do
    driven_by(:rack_test)
    create(:user, first_name: 'whatever', last_name: 'something', email: 'fake@mail.com', password: 'password')
  end

  describe 'login' do
    context 'missing required info' do
      it 'rejects form if missing email' do
        visit '/users/sign_in'
        fill_in 'Password', with: 'password'
        click_on 'Log in'
        expect(page).to have_content('Invalid Email or password.')
      end

      it 'rejects form if missing password' do
        visit '/users/sign_in'
        fill_in 'Email', with: 'person@email.com'
        click_on 'Log in'
        expect(page).to have_content('Invalid Email or password.')
      end
    end

    context 'email not registered' do
      it 'rejects form if email is not registered' do
        visit '/users/sign_in'
        fill_in 'Email', with: 'doesntexist@mail.com'
        click_on 'Log in'
        expect(page).to have_content('Invalid Email or password.')
      end
    end

    context 'email and password are valid' do
      it 'logs user in and redirects to news feed' do
        login
        expect(page).to have_content('Posts')
      end
    end
  end

  describe 'logout' do
    it 'logs user out and redirects to log in page' do
      login
      click_on 'Sign Out'
      expect(page).to have_content('Sign in')
    end
  end
end
