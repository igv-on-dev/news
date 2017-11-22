redis: redis-server --port 6479
sidekiq: bundle exec sidekiq
web: bundle exec puma -e development -p 5000 -S ~/puma -C config/puma.rb