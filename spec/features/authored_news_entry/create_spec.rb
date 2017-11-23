require "capybara_helper"

RSpec.feature "Create authored news entry", type: :feature do
  given!(:fetched_news_entry) { create(:fetched_news_entry) }
  given(:attributes) { attributes_for(:authored_news_entry) }

  it "updates content on main news page without page refreshing", js: true do
    visit root_path

    expect(page).to have_content(fetched_news_entry.title)
    expect(page).to have_content(fetched_news_entry.annotation)
    expect(page).to have_content(fetched_news_entry.decorate.published_at)

    new_window = open_new_window
    within_window new_window do
      visit admin_path

      expect(find_field('Title').value).to be_empty
      expect(find_field('Annotation').value).to be_empty
      expect(find_field('Unpublish at').value).to be_empty

      fill_in "Title", with: attributes[:title]
      fill_in "Annotation", with: attributes[:annotation]
      fill_in "Unpublish at", with: attributes[:unpublish_at]
      click_on "Create"

      expect(page).to have_content("News created successfully")
    end

    switch_to_window(windows.first)
    expect(page).to have_text(attributes[:title])
    expect(page).to have_text(attributes[:annotation])
  end
end
