require 'rails_helper'

RSpec.describe "Accessing links via API V1", type: :request do
  let!(:user) { User.create!(email_address: "steve@example.com", password: "password", password_confirmation: "password") }
  let!(:link) { Link.create!(title: "google", valid_url: "http://www.google.com", user_id: user.id) }
  let(:json) { JSON.parse(response.body) }

  context "updating a link" do
    it "can mark a link as read" do
      put "/api/v1/links/#{link.id}.json", {link: {read_status: true}}

      expect(response.status).to eq 204
      expect(Link.last.read_status).to eq true
    end
  end
end
