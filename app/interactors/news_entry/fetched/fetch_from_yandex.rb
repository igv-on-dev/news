require "yandex_main_news_fetcher"

class NewsEntry::Fetched::FetchFromYandex
  include Interactor

  def call
    news_entry = NewsEntry::Fetched.create(YandexMainNewsFetcher.current_main_news_attributes)

    if news_entry.persisted?
      NewsEntry::BroadcastCurrentMainNews.call
    else
      context.fail!
    end
  end
end