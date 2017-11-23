class NewsEntry::FetchedDecorator < Draper::Decorator
  delegate_all

  def published_at
    object[:published_at].strftime("%Y.%m.%d %H:%M")
  end
end
