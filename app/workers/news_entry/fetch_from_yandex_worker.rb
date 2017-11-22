class NewsEntry::FetchFromYandexWorker
  include Sidekiq::Worker

  def perform
    NewsEntry::Fetched::FetchFromYandex.call
  end
end
