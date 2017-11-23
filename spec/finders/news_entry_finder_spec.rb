require "rails_helper"

describe NewsEntryFinder do
  describe ".active_authored_news_entry" do
    context "when present active authored news entry" do
      let!(:active_authored_news_entry) { create(:authored_news_entry) }

      it "returns active authored news entry" do
        expect(NewsEntryFinder.active_authored_news_entry).to eq active_authored_news_entry
      end
    end

    context "when present non-active authored news entry" do
      let!(:non_active_authored_news) { create(:authored_news_entry, :non_active) }

      it "returns nil" do
        expect(NewsEntryFinder.active_authored_news_entry).to be nil
      end
    end

    context "when absent authored news entry" do
      it "returns nil" do
        expect(NewsEntryFinder.active_authored_news_entry).to be nil
      end
    end
  end

  describe ".main_news_entry" do
    let!(:first_fetched_news) { create(:fetched_news_entry) }
    let!(:last_fetched_news) { create(:fetched_news_entry) }

    context "when present active authored news entry" do
      let!(:active_authored_news_entry) { create(:authored_news_entry) }

      it "returns active authored news entry" do
        expect(NewsEntryFinder.main_news_entry).to eq active_authored_news_entry
      end
    end

    context "when present non-active authored news entry" do
      let!(:non_active_authored_news) { create(:authored_news_entry, :non_active) }

      it "returns last fetched news entry" do
        expect(NewsEntryFinder.main_news_entry).to eq last_fetched_news
      end

    end

    context "when absent authored news entry" do
      it "returns last fetched news entry" do
        expect(NewsEntryFinder.main_news_entry).to eq last_fetched_news
      end
    end
  end
end
