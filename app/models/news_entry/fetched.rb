class NewsEntry::Fetched < NewsEntry
  validates :published_at, presence: true
end
