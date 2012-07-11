Given /^there is a course$/ do
  @course = create(:course)
end

When /^I watch the course$/ do
  visit course_path(@course)
  click_link 'watch'
end

Then /^I should see a notice about the course watched$/ do
  page.should have_content('You have watched the course successfully.')
end
