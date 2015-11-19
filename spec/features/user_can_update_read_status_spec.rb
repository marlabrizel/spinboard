require 'rails_helper'

RSpec.describe "User can update the read status of a link", js: true do
  context "as an authenticated user" do
    let!(:user) { User.create!(email_address: "steve@example.com", password: "password", password_confirmation: "password") }

    context "with an unread link" do
      let!(:link) { Link.create!(title: "google", valid_url: "http://www.google.com", user_id: user.id) }

      it "can mark unread links as read" do

        log_in(user, root_path)

        expect(page).to have_button "Mark as read"

        click_button "Mark as read"
        expect(page).to have_button "Mark as unread"
        expect(page).not_to have_button "Mark as read"
      end
    end

    context "with a read link" do
      let!(:link) { Link.create!(title: "google", valid_url: "http://www.google.com", user_id: user.id, read_status: true) }

      it "can mark read links as unread" do

        log_in(user, root_path)

        expect(page).to have_button "Mark as unread"

        click_button "Mark as unread"
        expect(page).to have_button "Mark as read"
        expect(page).not_to have_button "Mark as unread"
      end
    end
  end
end
