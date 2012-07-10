Given /^the user don't have any account$/ do
end

When /^the user sign up with Email and desired password$/ do
  visit new_person_registration_path

  fill_in 'Email', with: 'rainux@gmail.com'
  fill_in 'Password', with: 'password'
  fill_in 'Password Confirmation', with: 'password'

  click_button 'Sign up'
end

Then /^the user has their account created$/ do
  page.should have_content('Welcome! You have signed up successfully.')
end
