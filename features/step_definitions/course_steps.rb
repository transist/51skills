Given /^there is an? (inactive |scheduled |)course$/ do |type|
  if type.strip == 'scheduled'
    @course = create(:scheduled_course)
  else
    @course = create(:course)
  end
end
