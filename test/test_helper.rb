ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"

module TestHelperMethods
  def log_in_as(user)
    post login_path, params: {name: user.name, password: user.password}
  end
end

class ActiveSupport::TestCase
  # Run tests in parallel with specified workers
  parallelize(workers: :number_of_processors)

  include TestHelperMethods
  include FactoryBot::Syntax::Methods
end
