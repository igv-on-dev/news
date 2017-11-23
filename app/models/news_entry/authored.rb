class NewsEntry::Authored < NewsEntry
  validates :unpublish_at, presence: true
end
