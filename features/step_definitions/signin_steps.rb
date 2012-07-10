When /^I sign in with email and password of the user$/ do
  visit new_person_session_path

  fill_in 'Email', with: @user.email
  fill_in 'Password', with: @user.password

  click_button 'Sign in'
end

Then /^I should be signed in$/ do
  page.should have_content('Signed in successfully.')
end
