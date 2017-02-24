require "sinatra/base"
require "sinatra/activerecord"
require "json"

# MODELS
require_relative "../models/category"
require_relative "../models/job"

# SERVICES
require "./services/job_service"
require "./services/category_service"
require 'will_paginate'
require 'will_paginate/active_record'

class ApplicationController < Sinatra::Base
  register Sinatra::ActiveRecordExtension

  set :method_override, true
  set :database_file, '../config/database.yml'

  before do
    content_type :json
  end

  def authenticate!
    halt 403 if req_params['token'] != '123abc'
  end

  def per_page
    params['per_page'] || 10
  end

  def req_params
    JSON.parse(request.body.read) rescue {}
  end
end
