require "rails_helper"

describe NewsEntry::Fetched::FetchFromYandex do
  describe ".call" do
    let!(:params) { attributes_for(:fetched_news_entry) }

    before do
      allow(YandexMainNewsFetcher).to receive(:current_main_news_attributes).and_return(params)
    end

    subject { NewsEntry::Fetched::FetchFromYandex.call }

    it "creates NewsEntry::Fetched" do
      expect{ subject }.to change{ NewsEntry::Fetched.count }
      expect(subject.success?).to be true
    end

    it "broadcast current main news" do
      expect(NewsEntry::BroadcastCurrentMainNews).to receive(:call)
      subject
    end

    context "when actual authored news entry exists" do
      let!(:authored_new_entry) { create(:authored_news_entry) }

      it "do not creates NewsEntry::Fetched" do
        expect{ subject }.not_to change{ NewsEntry::Fetched.count }
        expect(subject.success?).to be false
        expect(subject.message).to eq "There is currently active authored news, no needs to fetch"
      end
    end

    context "when same fetched news entry already active" do
      let!(:fetched_news_entry) { create(:fetched_news_entry) }

      it "do not creates NewsEntry::Fetched" do
        expect{ subject }.not_to change{ NewsEntry::Fetched.count }
        expect(subject.success?).to be false
        expect(subject.message).to eq "This news was already fetched"
      end
    end
  end
end
