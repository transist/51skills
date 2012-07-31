Given /^I already enrolled the course$/ do
  @current_user.enroll(@course)
end

Given /^I already enrolled the course without complete the payment$/ do
  @current_user.enroll(@course)
end

When /^I disenroll the course$/ do
  visit course_path(@course)
  click_link 'Disenroll'
end

When /^I cancel the payment$/ do
  visit course_path(@course)
  click_link 'Cancel'
end

Then /^I should see a notice about the course disenrolled$/ do
  page.should have_content('You have disenrolled the course successfully.')
end
