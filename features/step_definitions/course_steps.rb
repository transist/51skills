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
