require 'rails_helper'

RSpec.describe "User can submit a link", type: :feature do
  context "as an authenticated user" do
    let!(:user) { User.create!(email_address: "steve@example.com", password: "password", password_confirmation: "password") }

    it "can submit a link" do
      log_in(user, root_path)

      expect(page).to have_content("Submit a new link")

      fill_in "Title", with: "Link Title"
      fill_in "URL", with: "http://www.google.com"
      click_button "Submit"

      expect(current_path).to eq links_path
      expect(page).to have_content("Link Title")
    end

    it "cannot submit an valid link" do
      log_in(user, root_path)

      expect(page).to have_content("Submit a new link")

      fill_in "Title", with: "Invalid link title"
      fill_in "URL", with: "puppies"
      click_button "Submit"

      expect(page).not_to have_content("Invalid link title")
      expect(page).to have_content("Please enter a valid URL")
    end
  end

  context "as another user" do
    let!(:steve) { User.create!(email_address: "steve@example.com", password: "password", password_confirmation: "password") }
    let!(:rachel) { User.create!(email_address: "rachel@example.com", password: "password", password_confirmation: "password") }
    let!(:link) { Link.create!(title: "capybara world", valid_url: "https://capybaraworld.wordpress.com/", user_id: rachel.id) }

    it "can only see its own links" do
      log_in(rachel, root_path)

      expect(page).to have_content "capybara world"
      click_link "Log out"

      log_in(steve, root_path)

      expect(page).not_to have_content "capybara world"
    end
  end
end
