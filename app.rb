require "sinatra/base"
require "sinatra/activerecord"
require "json"
require 'byebug'

# MODELS
require "./models/category"
require "./models/job"

require 'will_paginate'
require 'will_paginate/active_record'

class JobsApplication < Sinatra::Base
  register Sinatra::ActiveRecordExtension

  set :method_override, true

  before do
    content_type :json
  end

  get '/jobs' do
    @posts = Job
             .order(updated_at: :desc)
             .paginate(page: params[:page], per_page: per_page)
    @posts.to_json
  end

  post '/jobs' do
    job_service = JobService.new(job_params).create
    job_service.to_json
  end

  def per_page
    params[:per_page] || 10
  end

  def job_params
    params = JSON.parse(request.body.read)
    params.slice(
      'category_id',
      'partner_id',
      'expired_at',
      'title',
      'category_external_code'
    )
  end

end
