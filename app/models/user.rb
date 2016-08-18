class User < ActiveRecord::Base
  has_many :notes
  validates_presence_of :username, :email, :password
  has_secure_password
end