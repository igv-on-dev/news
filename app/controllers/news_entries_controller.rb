class NewsEntriesController < ApplicationController
  def main
    @main_news_entry = NewsEntryFinder.main_news_entry
  end
end
