require "capybara_helper"
require "yandex_main_news_fetcher"

RSpec.feature "Fetch fresh news from yandex", type: :feature do
  let!(:news_entry) { create(:fetched_news_entry).decorate }
  let!(:fresh_news_attributes) do
    {
        title: "Fresh title",
        annotation: "Fresh annotation",
        published_at: Time.now.in_time_zone
    }
  end

  let!(:fresh_news_entry) { build(:fetched_news_entry, fresh_news_attributes).decorate }

  before do
    allow(YandexMainNewsFetcher).to receive(:current_main_news_attributes).and_return(fresh_news_attributes)
  end

  it "updates content on main news page without page refreshing", js: true do
    visit root_path

    expect(page).to have_content(news_entry.title)
    expect(page).to have_content(news_entry.annotation)
    expect(page).to have_content(news_entry.decorate.published_at)

    NewsEntry::FetchFromYandexWorker.new.perform

    expect(page).to have_content(fresh_news_entry.title)
    expect(page).to have_content(fresh_news_entry.annotation)
    expect(page).to have_content(fresh_news_entry.published_at)
  end
end
