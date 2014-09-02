def sign_in_admin(user)
  user.add_role(:admin) unless user.has_role?(:admin)
  visit new_user_session_path
  fill_in "user_email", with: user.email
  fill_in "user_password", with: user.password
  click_button "Log In"
end