class NewsEntry < ApplicationRecord
  validates :title, :annotation, presence: true
end
