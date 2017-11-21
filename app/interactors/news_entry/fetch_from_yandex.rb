require "yandex_main_news_fetcher"

class NewsEntry::FetchFromYandex
  include Interactor

  def call
    NewsEntry.create(YandexMainNewsFetcher.current_main_news_attributes)
  end
end