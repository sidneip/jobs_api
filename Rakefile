require 'rake/testtask'
require "bundler/setup"
require "sinatra/activerecord/rake"
Dir["./controllers/*.rb"].each {|file| require file }

task :default => ["run:development"]

namespace :run do
  desc "Start Development Server (local)"
  task :development do
    system "shotgun"
  end
end

Rake::TestTask.new do |t|
  t.pattern = 'test/**/*_test.rb'
end
