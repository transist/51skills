Given /^there is an? (inactive |scheduled |)course$/ do |type|
  if type.strip == 'scheduled'
    @course = create(:scheduled_course)
  else
    @course = create(:course)
  end
end

Given /^there is a scheduled free course$/ do
  @course = create(:scheduled_free_course)
end

Given /^I am on the course page$/ do
  visit course_path(@course)
end

Then /^I should be on the course page$/ do
  page.current_path.should == course_path(@course)
end
