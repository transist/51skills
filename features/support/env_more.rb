Spork.prefork do
  require 'factory_girl_rails'
  require 'capybara-screenshot'
  require 'capybara-webkit'

  Capybara.javascript_driver = :webkit
  Capybara.default_wait_time = 5

  class Cucumber::Rails::World
    extend ActionView::Helpers::SanitizeHelper::ClassMethods
    include ActionView::Helpers::SanitizeHelper
    include ActionView::Helpers::NumberHelper
    include FactoryGirl::Syntax::Methods
  end
end

Spork.each_run do
  # Requires supporting ruby files with custom matchers and macros, etc,
  # in spec/support/ and its subdirectories.
  Dir[Rails.root.join('spec/support/**/*.rb')].each {|f| require f }

  FactoryGirl.reload
  I18n.backend.reload!
end
