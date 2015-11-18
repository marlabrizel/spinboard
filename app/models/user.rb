class User < ActiveRecord::Base
  has_secure_password
  validates_confirmation_of :password, :message => "Password doesn't match!"
end
