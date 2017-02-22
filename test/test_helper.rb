ENV['RACK_ENV'] = 'test'

require File.expand_path(File.join(__dir__, '..', 'app.rb'))

require 'minitest/autorun'
require 'rack/test'
require 'capybara'
require 'capybara/dsl'
require 'database_cleaner'

module AcceptanceTest
  include Capybara::DSL

  def before_setup
    DatabaseCleaner.clean
    DatabaseCleaner.start
  end

  def self.included(_)
    Capybara.app, _ = Rack::Builder.parse_file(File.expand_path(File.join(__dir__, '..', 'config.ru')))
  end
end
