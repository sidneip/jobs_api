ENV['RACK_ENV'] = 'test'

require File.expand_path(File.join(__dir__, '..', 'controllers/' 'jobs_controller.rb'))
require File.expand_path(File.join(__dir__, '..', 'controllers/' 'categories_controller.rb'))

require 'minitest/autorun'
require 'rack/test'
require 'capybara'
require 'capybara/dsl'
require 'database_cleaner'

module TestHelpers
  include Capybara::DSL

  def before
    DatabaseCleaner.clean
    DatabaseCleaner.start
    super
  end

  def teardown 
    DatabaseCleaner.clean 
    super 
  end 

  def self.included(_)
    Capybara.app, _ = Rack::Builder.parse_file(File.expand_path(File.join(__dir__, '..', 'config.ru')))
  end
end
