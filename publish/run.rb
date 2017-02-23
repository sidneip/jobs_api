require_relative 'sidekiq_script.rb'
require './workers/import_jobs_worker.rb'
path = '/app/publish/jobs.txt'
ImportJobsWorker.perform_async(path)
