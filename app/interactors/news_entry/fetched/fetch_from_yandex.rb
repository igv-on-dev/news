require "yandex_main_news_fetcher"

class NewsEntry::Fetched::FetchFromYandex
  include Interactor

  def call
    if NewsEntryFinder.active_authored_news_entry
      context.fail!(message: "There is currently active authored news, no needs to fetch")
    end

    fetched_attributes = YandexMainNewsFetcher.current_main_news_attributes
    last_entry = NewsEntry::Fetched.last
    fields = %w(title annotation published_at)

    if fetched_attributes.stringify_keys.slice(*fields) == (last_entry && last_entry.attributes.slice(*fields))
      context.fail!(message: "This news was already fetched")
    end

    news_entry = NewsEntry::Fetched.create(fetched_attributes)

    if news_entry.persisted?
      NewsEntry::BroadcastCurrentMainNews.call
    else
      context.fail!
    end
  end
end