class Link < ActiveRecord::Base
  belongs_to :user
  
  validates :valid_url, url: true
end
