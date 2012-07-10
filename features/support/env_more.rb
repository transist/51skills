Spork.prefork do
  require 'capybara-screenshot'
  require 'capybara-webkit'

  Capybara.javascript_driver = :webkit

  class Cucumber::Rails::World
    extend ActionView::Helpers::SanitizeHelper::ClassMethods
    include ActionView::Helpers::SanitizeHelper
    include ActionView::Helpers::NumberHelper
  end
end

Spork.each_run do
  require 'factory_girl_rails'

  # Requires supporting ruby files with custom matchers and macros, etc,
  # in spec/support/ and its subdirectories.
  Dir[Rails.root.join('spec/support/**/*.rb')].each {|f| require f }

  FactoryGirl.reload
  I18n.backend.reload!
end
