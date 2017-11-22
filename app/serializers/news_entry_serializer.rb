class NewsEntrySerializer
  attr_reader :object

  class << self
    def call(*args)
      new(*args).call
    end
  end

  def initialize(news_entry)
    @object = news_entry
  end

  def call
    {
        id: object.id,
        title: object.title,
        annotation: object.annotation,
        published_at: object.published_at
    }
  end
end