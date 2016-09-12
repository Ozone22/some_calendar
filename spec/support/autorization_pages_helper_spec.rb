def sign_in(user, remember_me = false)
  visit signin_path
  fill_in 'Email', with: user.email
  fill_in 'Password', with: user.password
  check 'Remember me' if remember_me
  click_button 'Sign in'
end