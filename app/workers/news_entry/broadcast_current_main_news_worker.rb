class NewsEntry::BroadcastCurrentMainNewsWorker
  include Sidekiq::Worker

  def perform
    NewsEntry::BroadcastCurrentMainNews.call
  end
end
