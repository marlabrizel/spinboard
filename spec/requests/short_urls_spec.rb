require 'rails_helper'

RSpec.describe "Short Urls Controller", type: :request do
  let!(:user) { User.create!(email_address: "steve@example.com", password: "password", password_confirmation: "password") }
  let!(:link) { Link.create!(title: "google", valid_url: "http://www.google.com", user_id: user.id) }
  let(:json) { JSON.parse(response.body) }

  context "visiting link via slug" do
    it "is redirected to external link when slug is clicked" do
      get "/s/#{link.slug}"
      expect(response.status).to eq 302
      expect(response.redirect_url).to eq "http://www.google.com"
    end
  end
end
