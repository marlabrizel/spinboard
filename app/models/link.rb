class Link < ActiveRecord::Base
  belongs_to :user

  validates :valid_url, url: true

  after_create :shorten_url

  def shorten_url
    self.slug = self.id.to_s(36)
    self.save
    self.slug
  end

  def display_slug
    ENV['BASE_URL'] + self.slug
  end
end
