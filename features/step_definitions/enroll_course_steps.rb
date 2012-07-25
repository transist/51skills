Given /^I already enrolled the course$/ do
  @current_user.enroll(@course)
end

When /^I enroll the course$/ do
  visit course_path(@course)
  click_link 'Enroll'
end

When /^I disenroll the course$/ do
  visit course_path(@course)
  click_link 'Disenroll'
end

Then /^I should see a notice about the course enrolled$/ do
  page.should have_content('You have enrolled the course successfully.')
end

Then /^I should see a notice about the course disenrolled$/ do
  page.should have_content('You have disenrolled the course successfully.')
end
