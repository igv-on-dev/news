class NewsEntryFinder
  def self.active_authored_news_entry
    NewsEntry::Authored.where("unpublish_at > ?", Time.now.in_time_zone).last
  end

  def self.main_news_entry
    active_authored_news_entry || NewsEntry::Fetched.last
  end
end