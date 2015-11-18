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

# As an authenticated user viewing the main page (links#index), I should see a simple form to submit a link.
#
# The Link model should include:
#
# A valid URL location for the link
# A title for the link
# Additionally, all links have a read status that is either true or false. This column will default to false.
#
# Submitting an invalid link should result in an error message being displayed.
#
# Hint: Use Ruby's built in URI.parse method to determine if a link is a valid URL or not. This StackOverflow post has more information. Alternatively, you could use a gem like this one.
#
# Once a link has been submitted, loading the index page should display all of my links.
