require "sinatra/base"
require "sinatra/activerecord"
require "json"
require 'byebug'

# MODELS
require_relative "../models/category"
require_relative "../models/job"

# SERVICES
require "./services/job_service"
require 'will_paginate'
require 'will_paginate/active_record'

class CategoriesController < Sinatra::Base
  register Sinatra::ActiveRecordExtension
  set :database_file, '../config/database.yml'
  set :method_override, true

  before do
    content_type :json
  end

  get '/' do
    @categories = Category
             .order(updated_at: :desc)
             .paginate(page: params[:page], per_page: per_page)
    @categories.to_json
  end

  def per_page
    params[:per_page] || 10
  end

  def job_params
    params = JSON.parse(request.body.read)
  end

end
