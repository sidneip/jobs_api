require 'simplecov'
SimpleCov.start do
  add_filter 'test'
  add_group 'Models', 'models'
  add_group 'Controllers', 'controllers'
  add_group 'Services', 'services'
end

ENV['RACK_ENV'] = 'test'

require File.expand_path(File.join(__dir__, '..', 'controllers/' 'application_controller.rb'))
require File.expand_path(File.join(__dir__, '..', 'controllers/' 'jobs_controller.rb'))
require File.expand_path(File.join(__dir__, '..', 'controllers/' 'categories_controller.rb'))

require 'minitest/autorun'
require 'rack/test'
require 'capybara'
require 'capybara/dsl'
require 'database_cleaner'
require 'byebug'
require "minitest/reporters"

Minitest::Reporters.use!

module TestHelpers
	DatabaseCleaner.strategy = :transaction
	DatabaseCleaner.clean_with(:truncation)
  include Capybara::DSL

  def before_setup
    super
    DatabaseCleaner.clean
    DatabaseCleaner.start
  end

  def before
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

  def json_parse(body)
    JSON.parse(body) rescue {}
  end

  def get_json(path, method = 'get')
    body = send(method, path).body
    json_parse(body)
  end

  def create_multiple_jobs(number)
    number.times do |t|
      job_params = {
        'category_external_code' => 12332110,
        "partner_id" => "12332111#{t}",
        'title' => 'dev',
        'expired_at' => DateTime.now + 10
      }
      JobService.new(job_params).save
    end
  end
end
