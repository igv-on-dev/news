class NewsEntry::Authored::Update
  include Interactor

  def call
    news_entry = NewsEntry::Authored.find(context.news_entry_id)
    news_entry.update(context.params)

    context.news_entry = news_entry

    if news_entry.changed?
      context.fail!(message: news_entry.errors.full_messages.join("; "))
    else
      NewsEntry::BroadcastCurrentMainNewsWorker.perform_at(news_entry.unpublish_at + 15.seconds)
      NewsEntry::BroadcastCurrentMainNews.call
    end
  end
end
