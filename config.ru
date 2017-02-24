require "sinatra/base"

require File.expand_path '../controllers/application_controller.rb', __FILE__
require File.expand_path '../controllers/jobs_controller.rb', __FILE__
require File.expand_path '../controllers/categories_controller.rb', __FILE__

map "/jobs" do
    run JobsApplication
end

map "/categories" do
    run CategoriesController
end
