Given /^there is an? (inactive|scheduled|) course$/ do |type|
  if type == "scheduled"
    @course = create(:course_with_start_date)
  else
    @course = create(:course)
  end
    
end

When /^I watch the course$/ do
  visit course_path(@course)
  click_link 'Watch'
end

Then /^I should see a notice about the course watched$/ do
  page.should have_content('You have watched the course successfully.')
end
