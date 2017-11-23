class NewsEntry::Authored::Create
  include Interactor

  def call
    news_entry = NewsEntry::Authored.create(context.params)
    context.news_entry = news_entry

    if news_entry.persisted?
      NewsEntry::BroadcastCurrentMainNewsWorker.perform_at(news_entry.unpublish_at + 15.seconds)
      NewsEntry::BroadcastCurrentMainNews.call
    else
      context.fail!(message: news_entry.errors.full_messages.join("; "))
    end
  end
end
