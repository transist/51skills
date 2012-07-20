Given /^there is an? (user|admin)$/ do |user_or_admin|
  @user = create(user_or_admin.to_sym)
end