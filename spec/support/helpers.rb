def login
  visit '/users/sign_in'
  fill_in 'Email', with: 'fake@mail.com'
  fill_in 'Password', with: 'password'
  click_on 'Log in'
end

def create_post
  click_on 'New Post'
  fill_in 'Content', with: 'text for new post'
  click_on 'Create Post'
end