ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
  
  # Returns true if a test user is logged in.
  def is_logged_in?
    !session[:user_id].nil?
  end
  
  # Logs in a test user.
  def log_in_as(user, options = {})
    # use "password" as default unless one was provided as option
    password = options[:password] || "password"
    if integration_test?
      post login_path, session: { username: user.username,
                                  password: password }
    else
      session[:user_id] = user.id
    end
  end

  private

    # Returns true inside an integration test.
    def integration_test?
      # post_via_redirect is only defined in integration tests
      defined?(post_via_redirect)
    end
end
