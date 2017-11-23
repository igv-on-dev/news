require "capybara_helper"

RSpec.feature "Update active authored news entry", type: :feature do
  let!(:news_entry) { create(:authored_news_entry).decorate }
  let(:updated_title) { "My new title" }


  it "updates content on main news page without page refreshing", js: true do
    visit root_path

    expect(page).to have_content(news_entry.title)
    expect(page).to have_content(news_entry.annotation)
    expect(page).to have_content(news_entry.decorate.published_at)

    new_window = open_new_window
    within_window new_window do
      visit admin_path

      expect(find_field('Title').value).to eq(news_entry.title)
      expect(find_field('Annotation').value).to eq(news_entry.annotation)
      expect(find_field('Unpublish at').value).to eq(news_entry.unpublish_at)

      fill_in "Title", with: updated_title
      click_on "Save"
    end

    switch_to_window(windows.first)
    expect(page).to have_text(updated_title)
  end
end
