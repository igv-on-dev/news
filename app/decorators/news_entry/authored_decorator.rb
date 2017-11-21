class NewsEntry::AuthoredDecorator < Draper::Decorator
  delegate_all

  def unpublish_at
    object.unpublish_at.strftime("%Y.%m.%d %H:%M")
  end

  def published_at
    object.created_at.strftime("%Y.%m.%d %H:%M")
  end
end