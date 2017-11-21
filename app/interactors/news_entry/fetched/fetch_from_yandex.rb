require "yandex_main_news_fetcher"

class NewsEntry::Fetched::FetchFromYandex
  include Interactor

  def call
    NewsEntry::Fetched.create(YandexMainNewsFetcher.current_main_news_attributes)
  end
end