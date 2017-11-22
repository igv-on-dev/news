class NewsEntry::BroadcastCurrentMainNews
  include Interactor

  def call
    content = NewsEntrySerializer.call(NewsEntryFinder.main_news_entry.decorate)
    ActionCable.server.broadcast 'main_news_entry', content: content
  end
end
