# This file is copied to spec/ when you run 'rails generate rspec:install'
require 'jwt'
require 'spec_helper'
ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
# Prevent database truncation if the environment is production
abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'rspec/rails'

require 'shoulda/matchers'
Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    # Choose a test framework:
    with.test_framework :rspec

    # Choose one or more libraries:
    with.library :rails
  end
end

# This module defines a set of helper methods that can be included in controller specs
# to simplify the testing process. The `create_admin` method creates a new admin user
# record in the database with default or custom attributes, making it easy to create
# test users for admin-only functionality.
module ControllerHelpers
  def create_admin(attrs = {})
    Admin.create!(
      name: attrs[:name] || 'Admin Name',
      email: attrs[:email] || 'admin@example.com',
      password: attrs[:password] || 'password',
      password_confirmation: attrs[:password_confirmation] || 'password'
    )
  end
end

# This module defines a helper method for generating JSON Web Tokens (JWTs)
# that can be used for user authentication and authorization. The `generate_token`
# method takes an `admin_id` parameter, which is used to create a JWT payload
# with the admin user's ID as the only value. The payload is then encoded using
# the Rails application's secret key base, which should be kept secret and not
# shared or exposed. The resulting JWT can be used to authenticate the admin user
# for protected routes and actions.
module JwtHelper
  def generate_token(admin_id)
    payload = { admin_id: admin_id }
    JWT.encode(payload, Rails.application.secrets.secret_key_base)
  end
end

RSpec.configure do |config|
  config.include ControllerHelpers, type: :controller
end

require 'simplecov'
SimpleCov.start

# Add additional requires below this line. Rails is not loaded until this point!

# Requires supporting ruby files with custom matchers and macros, etc, in
# spec/support/ and its subdirectories. Files matching `spec/**/*_spec.rb` are
# run as spec files by default. This means that files in spec/support that end
# in _spec.rb will both be required and run as specs, causing the specs to be
# run twice. It is recommended that you do not name files matching this glob to
# end with _spec.rb. You can configure this pattern with the --pattern
# option on the command line or in ~/.rspec, .rspec or `.rspec-local`.
#
# The following line is provided for convenience purposes. It has the downside
# of increasing the boot-up time by auto-requiring all files in the support
# directory. Alternatively, in the individual `*_spec.rb` files, manually
# require only the support files necessary.
#
Dir[Rails.root.join('spec', 'support', '**', '*.rb')].sort.each { |f| require f }

# Checks for pending migrations and applies them before tests are run.
# If you are not using ActiveRecord, you can remove these lines.
begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  puts e.to_s.strip
  exit 1
end
RSpec.configure do |config|
  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = true

  # You can uncomment this line to turn off ActiveRecord support entirely.
  # config.use_active_record = false

  # RSpec Rails can automatically mix in different behaviours to your tests
  # based on their file location, for example enabling you to call `get` and
  # `post` in specs under `spec/controllers`.
  #
  # You can disable this behaviour by removing the line below, and instead
  # explicitly tag your specs with their type, e.g.:
  #
  #     RSpec.describe UsersController, type: :controller do
  #       # ...
  #     end
  #
  # The different available types are documented in the features, such as in
  # https://relishapp.com/rspec/rspec-rails/docs
  config.infer_spec_type_from_file_location!

  # Filter lines from Rails gems in backtraces.
  config.filter_rails_from_backtrace!
  # arbitrary gems may also be filtered via:
  # config.filter_gems_from_backtrace("gem name")
end
