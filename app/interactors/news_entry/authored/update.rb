class NewsEntry::Authored::Update
  include Interactor

  def call
    news_entry = NewsEntry::Authored.find(context.news_entry_id)
    news_entry.update(context.params)

    context.news_entry = news_entry

    if news_entry.persisted?
      NewsEntry::BroadcastCurrentMainNews.call
    else
      context.fail!
    end
  end
end