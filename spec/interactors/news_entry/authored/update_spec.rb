require "rails_helper"

describe NewsEntry::Authored::Update do
  describe ".call" do
    let!(:active_authored_news_entry) { create(:authored_news_entry) }
    let!(:params) { attributes_for(:authored_news_entry).merge(unpublish_at: Time.now.in_time_zone + 1.hour) }
    subject { NewsEntry::Authored::Update.call(params: params, news_entry_id: active_authored_news_entry.id) }

    it "updates NewsEntry::Authored" do
      expect{ subject }
        .to change{ active_authored_news_entry.reload.unpublish_at }
        .to(params[:unpublish_at])
      expect(subject.success?).to be true
    end

    it "schedules NewsEntry::BroadcastCurrentMainNewsWorker at unpublish_at time" do
      expect(NewsEntry::BroadcastCurrentMainNewsWorker)
        .to receive(:perform_at)
        .with(params[:unpublish_at] + 15.seconds)
      subject
    end

    it "broadcast current main news" do
      expect(NewsEntry::BroadcastCurrentMainNews).to receive(:call)
      subject
    end
  end
end
