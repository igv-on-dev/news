class NewsEntry::Authored::Create
  include Interactor

  def call
    news_entry = NewsEntry::Authored.create(context.params)
    context.news_entry = news_entry

    if news_entry.persisted?
      context.flash_message = { success: "News created successfully" }
      NewsEntry::BroadcastCurrentMainNewsWorker.perform_at(news_entry.unpublish_at + 15.seconds)
      NewsEntry::BroadcastCurrentMainNews.call
    else
      context.flash_message = { error: "Creation failed" }
      context.fail!
    end
  end
end