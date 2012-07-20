When /^I enroll the course$/ do
  visit course_path(@course)
  click_link 'Enroll'
end

Then /^I should see a notice about the course enrolled$/ do
  page.should have_content('You have enrolled the course successfully.')
end