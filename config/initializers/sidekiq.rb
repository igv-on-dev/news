Sidekiq.configure_server do |config|
  config.redis = { url: 'redis://localhost:6479/10' }
end