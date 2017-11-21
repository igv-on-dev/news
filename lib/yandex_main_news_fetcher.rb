class YandexMainNewsFetcher
  attr_reader :page_body, :main_news_attributes

  class << self
    def current_main_news_attributes
      new.current_main_news_attributes
    end
  end

  def initialize; end

  def current_main_news_attributes
    fetch_news_feed_page
    extract_main_news_attributes
    correct_date_attribute
    main_news_attributes
  end

  private

  def fetch_news_feed_page
    uri = URI("https://news.yandex.ru/")
    @page_body = Net::HTTP.get_response(uri).body.force_encoding("UTF-8")
  end

  def extract_main_news_attributes
    doc = Nokogiri::HTML(page_body)
    block = doc.css("div.story_view_main")

    @main_news_attributes = {}
    main_news_attributes[:title]        = block.css("h2 a").first.text
    main_news_attributes[:annotation]   = block.css("div.story__text").first.text
    main_news_attributes[:published_at] = block.css("div.story__date").first.text
  end

  def correct_date_attribute
    date_regexp = /(?<yesterday>вчера)?[[:space:]]в[[:space:]]\n?(?<hours>\d{2}):(?<minutes>\d{2})\z/m
    match_result = main_news_attributes[:published_at].match(date_regexp)
    date = match_result["yesterday"] ? Date.yesterday.in_time_zone : Date.today.in_time_zone
    main_news_attributes[:published_at] = date + match_result["hours"].to_i.hours + match_result["minutes"].to_i.minutes
  end
end