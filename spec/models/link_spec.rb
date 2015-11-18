require 'rails_helper'

RSpec.describe Link, type: :model do
  it "automatically assigns a slug based on link id" do
    link = Link.create!({title: "title", valid_url: "http://google.com"})

    expect(link.slug).not_to be_nil
    expect(link.slug).to eq link.id.to_s(36)
  end
end
