Given /^I don't have any account$/ do
end

When /^I sign up with Email and desired password$/ do
  visit new_person_registration_path
  
  fill_in 'Email', with: 'example@example.com'
  fill_in 'Password', with: 'password'
  fill_in 'Password Confirmation', with: 'password'
  
  click_button 'Sign up'
end

Then /^I have my account created$/ do
  page.should have_content('Welcome! You have signed up successfully.')
end

When /^I sign up with Email and unmatched password$/ do
  visit new_person_registration_path
  
  fill_in 'Email', with: 'example@example.com'
  fill_in 'Password', with: 'password'
  fill_in 'Password Confirmation', with: 'password1'
  
  click_button 'Sign up'
end

Then /^I get an error$/ do
  page.has_selector? 'error_explanation'
end

Then /^The error tells me two passwords should be the same$/ do
  page.should have_content "Password doesn't match confirmation"
end


