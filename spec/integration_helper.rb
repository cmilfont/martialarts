require 'spec_helper'

require 'capybara/rspec'
require 'capybara/rails'
#require 'capybara/poltergeist'

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.

Dir[Rails.root.join("spec/features/macros/**/*.rb")].each { |f| require f }

include Warden::Test::Helpers
Warden.test_mode!

Capybara.configure do |config|
  #config.javascript_driver = :poltergeist
  config.ignore_hidden_elements = true
  config.default_selector = :css
  config.default_wait_time = 10
end

RSpec.configure do |config|
  config.include Helpers
  #config.after(:all, type: :request) { delete_movie_index }
  config.include Capybara::DSL, :type => :request
  config.use_transactional_fixtures = false

end