require 'simplecov'

SimpleCov.start 'rails'

# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'rspec/autorun'

require 'shoulda'
require 'database_cleaner'
require "paperclip/matchers"

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }
Dir[Rails.root.join("spec/factories/**/*.rb")].each {|f| require f}

# Checks for pending migrations before tests are run.
# If you are not using ActiveRecord, you can remove this line.
ActiveRecord::Migration.check_pending! if defined?(ActiveRecord::Migration)

RSpec.configure do |config|
  config.include Paperclip::Shoulda::Matchers
  
  config.include Devise::TestHelpers, :type => :controller
  
  DatabaseCleaner.logger = Rails.logger

  config.before(:each) do
    DatabaseCleaner.strategy = :deletion
    DatabaseCleaner.start
    Rails.cache.clear
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end
  
  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  
  config.use_transactional_fixtures = true
  config.infer_base_class_for_anonymous_controllers = true

end