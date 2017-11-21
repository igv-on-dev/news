class NewsEntry::Authored::Update
  include Interactor

  def call
    news_entry = NewsEntry::Authored.find(context.news_entry_id)
    news_entry.update(context.params)

    if news_entry.persisted?
      context.news_entry = news_entry
    else
      context.fail!
    end
  end
end