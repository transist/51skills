When /^I sign in with email and password of the user$/ do
  visit new_person_session_path

  fill_in 'Email', with: @user.email
  fill_in 'Password', with: @user.password
  
  puts @user.email
  puts @user.password

  click_button 'Sign in'
end

Then /^I should be signed in$/ do
  page.should have_content('Signed in successfully.')
end

Given /^I am signed in as (a user|an admin)$/ do |user_or_admin|
  steps %Q{
    Given there is #{user_or_admin}
    When I sign in with email and password of the user
  }
end