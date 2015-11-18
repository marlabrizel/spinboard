require 'rails_helper'

RSpec.describe "User can edit a link" do
  context "as an authenticated user" do
    let!(:user) { User.create!(email_address: "steve@example.com", password: "password", password_confirmation: "password") }
    let!(:link) { Link.create!(title: "google", valid_url: "http://www.google.com", user_id: user.id) }

    it "can edit a link" do
      log_in(user, root_path)

      expect(page).to have_content "google"
      expect(page).to have_content "http://www.google.com"

      click_button "Edit"
      fill_in "Title", with: "Twitter"
      fill_in "URL", with: "http://www.twitter.com"
      click_button "Update Link"

      expect(page).to have_content "Twitter"
      expect(page).to have_content "http://www.twitter.com"
      expect(page).not_to have_content "google"
      expect(page).not_to have_content "http://www.google.com"
    end

    it "cannot edit a link with invalid params" do
      log_in(user, root_path)

      expect(page).to have_content "google"
      expect(page).to have_content "http://www.google.com"

      click_button "Edit"
      fill_in "Title", with: "I love puppies"
      fill_in "URL", with: "puppies"
      click_button "Update Link"

      expect(page).to have_content "Please enter a valid URL"
    end
  end
end
