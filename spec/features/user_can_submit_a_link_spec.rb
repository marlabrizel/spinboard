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
end
