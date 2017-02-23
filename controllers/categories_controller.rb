require "sinatra/base"
require "sinatra/activerecord"
require "json"

# MODELS
require_relative "../models/category"
require_relative "../models/job"

# SERVICES
require "./services/category_service"
require 'will_paginate'
require 'will_paginate/active_record'

class CategoriesController < Sinatra::Base
  register Sinatra::ActiveRecordExtension
  set :database_file, '../config/database.yml'
  set :method_override, true

  before do
    content_type :json
  end

  get '/:id' do
    @categories = CategoryService.new(params[:id]).calculate
    @categories.to_json
  end

  def per_page
    params[:per_page] || 10
  end

  def job_params
    params = JSON.parse(request.body.read)
  end

end
