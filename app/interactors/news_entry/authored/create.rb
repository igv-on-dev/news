class NewsEntry::Authored::Create
  include Interactor

  def call
    news_entry = NewsEntry::Authored.create(context.params)

    if news_entry.persisted?
      context.news_entry = news_entry
      context.flash_message = { success: "News created successfully" }
    else
      context.flash_message = { error: "Creation failed" }
      context.fail!
    end
  end
end