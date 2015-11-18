require 'rails_helper'

RSpec.feature "User can log in and log out", type: :feature do
  context "as a registered user" do
    let!(:user) { User.create!(email_address: "steve@example.com", password: "password", password_confirmation: "password") }

    it "can log in" do
      visit root_path
      click_link "Log In"
      fill_in "Email address", with: "steve@example.com"
      fill_in "Password", with: "password"
      click_button "Log In"

      expect(current_path).to eq links_path
    end

    it "can log out" do
      log_in(user, root_path)

      click_link "Log out"

      expect(current_path).to eq login_path
    end
  end
end
