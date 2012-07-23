Given /^meta data for course creation$/ do
  @sub_category = create(:sub_category)
  @category = @sub_category.parent
end

When /^I create a course$/ do
  visit new_course_path
  select('Programming', :from => 'main_category_select')
  wait_until(1){page.should have_content('Web')}
  click_on 'Create'
end

Then /^course should be created$/ do
  page.should have_content('The course successfully created!')
end

When /^I activate the inactive course$/ do
  visit edit_course_path(@course)
  click_on 'activate'
end

Then /^the course state should be changed to active$/ do
  find("#state").should have_content("active")
  find_link('schedule').visible?
end
