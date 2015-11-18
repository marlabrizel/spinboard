class Link < ActiveRecord::Base
  validates :valid_url, url: true
end
