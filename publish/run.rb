require_relative 'sidekiq_script.rb'
require_relative 'workers/import_jobs_worker.rb'
path = '/app/publish/jobs.txt'
puts "###### START IMPORT FILE ######"
ImportJobsWorker.perform_async(path)
