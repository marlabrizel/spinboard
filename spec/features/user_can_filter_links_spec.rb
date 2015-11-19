require 'rails_helper'

RSpec.describe "User can filter links", js: true do
  context "as an authenticated user with links" do
    let!(:rachel) { User.create!(email_address: "rachel@example.com", password: "password", password_confirmation: "password") }
    let!(:capybaras) { Link.create!(title: "capybara world", valid_url: "https://capybaraworld.wordpress.com/", user_id: rachel.id) }
    let!(:apple) { Link.create!(title: "apple", valid_url: "http://www.apple.com/", user_id: rachel.id, read_status: true) }

    it "can filter by read status" do
      log_in(rachel, root_path)

      expect(page).to have_content "capybara world"
      expect(page).to have_content "apple"

      click_button "Read"
      expect(page).to have_content "apple"
      expect(page).not_to have_content "capybara world"

      click_button "Unread"
      expect(page).to have_content "capybara world"
      expect(page).not_to have_content "apple"

      click_button "Show All"
      expect(page).to have_content "capybara world"
      expect(page).to have_content "apple"
    end

    it "can search for content" do
      log_in(rachel, root_path)

      expect(page).to have_content "capybara world"
      expect(page).to have_content "apple"

      fill_in "Search for a link", with: "capy"

      expect(page).to have_content "capybara world"
      expect(page).not_to have_content "apple"
    end

    it "can sort by ascending" do
      log_in(rachel, root_path)

      click_button "Sort Ascending"
      link_order = page.all('.link h3').map(&:text)

      expect(link_order).to eq ["apple", "capybara world"]
    end

    it "can sort by descending" do
      log_in(rachel, root_path)

      click_button "Sort Descending"
      link_order = page.all('.link h3').map(&:text)

      expect(link_order).to eq ["capybara world", "apple"]
    end
  end
end
