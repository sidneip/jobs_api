web: bundle exec unicorn -p 9292 -c ./config/unicorn.rb
worker: bundle exec sidekiq -r ./publish/sidekiq_script.rb -C ./publish/config/sidekiq.yml
import: ruby ./public/run.rb
