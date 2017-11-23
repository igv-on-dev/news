require "rails_helper"
require "yandex_main_news_fetcher"

describe YandexMainNewsFetcher do
  around(:each) do |example|
    WebMock.disable_net_connect!
    example.run
    WebMock.allow_net_connect!
  end

  describe ".current_main_news_attributes" do
    let!(:request) do
      stub_request(:get, "https://news.yandex.ru/")
          .with(headers: {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3'})
          .to_return(status: 200, body: ExternalServicesStabs.yandex_news_page)
    end

    subject { YandexMainNewsFetcher.current_main_news_attributes }
    before { subject }

    it "makes request to https://news.yandex.ru/" do
      expect(request).to have_been_requested
    end

    it "returns a Hash" do
      expect(subject[:title]).to be_a String
      expect(subject[:title]).to be_present
      expect(subject[:annotation]).to be_a String
      expect(subject[:annotation]).to be_present
      expect(subject[:published_at]).to be_a Time
    end
  end
end
