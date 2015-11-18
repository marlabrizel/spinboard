require 'rails_helper'

RSpec.feature "Visitor can sign up and log in", type: :feature do
  context "as a non-registered user" do
    it "can sign up" do
      visit root_path
      click_link "Sign Up"

      fill_in "Email address", with: "hello@example.com"
      fill_in "Password", with: "password"
      fill_in "Password confirmation", with: "password"
      click_button "Sign Up"

      expect(current_path).to eq(links_path)
    end
  end
end
