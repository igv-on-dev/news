require "rails_helper"

describe NewsEntry::Authored::Create do
  describe ".call" do
    let!(:params) { attributes_for(:authored_news_entry) }
    subject { NewsEntry::Authored::Create.call(params: params) }

    it "creates NewsEntry::Authored" do
      expect{ subject }.to change{ NewsEntry::Authored.count }.by(1)
      expect(subject.success?).to be true
    end

    it "schedules NewsEntry::BroadcastCurrentMainNewsWorker at unpublish_at time" do
      expect(NewsEntry::BroadcastCurrentMainNewsWorker).to receive(:perform_at)
        .with(params[:unpublish_at] + 15.seconds)
      subject
    end

    it "broadcast current main news" do
      expect(NewsEntry::BroadcastCurrentMainNews).to receive(:call)
      subject
    end
  end
end
