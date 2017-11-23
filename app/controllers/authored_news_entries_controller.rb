class AuthoredNewsEntriesController < ApplicationController
  def new
    @authored_news_entry = active_authored_news_entry || NewsEntry::Authored.new
  end

  def create
    result = NewsEntry::Authored::Create.call(params: news_entry_params)
    if result.success?
      redirect_to admin_path, success: "News created successfully"
    else
      @authored_news_entry = result.news_entry
      flash[:error] = "Creation failed: #{result.message}"
      render :new
    end
  end

  def update
    result = NewsEntry::Authored::Update.call(news_entry_id: news_entry_id, params: news_entry_params)

    if result.success?
      redirect_to admin_path, success: "News updated successfully"
    else
      @authored_news_entry = result.news_entry
      flash[:error] = "Update failed: #{result.message}"
      render :new
    end
  end

  private

  def news_entry_params
    params.require(:news_entry_authored).permit(:title, :annotation, :unpublish_at)
  end

  def news_entry_id
    params.require(:news_entry_authored).require(:id)
  end

  def active_authored_news_entry
    new_entry = NewsEntryFinder.active_authored_news_entry
    new_entry ? new_entry.decorate : nil
  end
end
