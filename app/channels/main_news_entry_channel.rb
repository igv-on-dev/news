class MainNewsEntryChannel < ApplicationCable::Channel
  def subscribed
    stream_from "main_news_entry"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
