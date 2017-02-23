require 'sidekiq'
require 'csv'
require 'byebug'
require_relative '../job'

class ImportJobsWorker
  include Sidekiq::Worker
  sidekiq_options queue: 'import_file', retry: false, backtrace: true

  def perform(path)
    jobs = CSV.read(path, col_sep: '|', headers: true)
    jobs.each do |job|
      Job.new(
        title: job['title'],
        category_external_code: job['categoryId'],
        expired_at: job['ExpiresAt'],
        partner_id: job['partnerId']
      ).save
    end
  end
end
