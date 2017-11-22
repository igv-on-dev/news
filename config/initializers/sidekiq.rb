Sidekiq.configure_server do |config|
  config.redis = { url: 'redis://localhost:6479/10' }
  config.on(:startup) do
    NewsEntry::FetchFromYandexWorker.perform_async
  end
end

Sidekiq.configure_client do |config|
  config.redis = { url: 'redis://localhost:6479/10' }
end

schedule_file = "config/schedule.yml"
if File.exists?(schedule_file) && Sidekiq.server?
  Sidekiq::Cron::Job.load_from_hash YAML.load_file(schedule_file)
end