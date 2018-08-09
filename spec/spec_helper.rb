# frozen_string_literal: true

require "simplecov"
SimpleCov.start("rails")

require "bundler/setup"
require "tolken"
require "with_model"
require "pry"

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.extend(WithModel)

  config.before(:suite) do
    database_name = ENV["TRAVIS"] ? "travis_ci_test" : "tolken_test"
    ActiveRecord::Base.establish_connection("postgres://localhost/#{database_name}?pool=5")

    I18n.available_locales = %i[en sv de]
    I18n.enforce_available_locales = true
    I18n.default_locale = :en
  end
end
