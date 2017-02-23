require 'sidekiq'
require_relative 'settings'

Sidekiq.configure_client do |config|
  config.redis = { url: AppConfig.redis['url'] }
end

Sidekiq.configure_server do |config|
  config.redis = { url: AppConfig.redis['url'] }
end

require_relative './workers/import_jobs_worker'
