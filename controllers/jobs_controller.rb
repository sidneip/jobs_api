require "sinatra/base"
require "sinatra/activerecord"
require "json"

# MODELS
require_relative "../models/category"
require_relative "../models/job"

# SERVICES
require "./services/job_service"
require 'will_paginate'
require 'will_paginate/active_record'

class JobsApplication < Sinatra::Base
  register Sinatra::ActiveRecordExtension

  set :method_override, true
  set :database_file, '../config/database.yml'
  before do
    content_type :json
  end

  get '/' do
    @jobs = Job
             .order(updated_at: :desc)
             .paginate(page: params[:page], per_page: per_page)
    @jobs.to_json
  end

  post '/' do
    begin
      @job_service = JobService.new(job_params).save
      @job_service.to_json
    rescue ActiveRecord::RecordInvalid => e
      status 422
      { error: e }.to_json
    end
  end

  post "/:id/activate" do
    @job = Job.find params["id"]
    @job.activate!
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
      'category_external_code',
    )
  end

end
