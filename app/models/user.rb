class User < ActiveRecord::Base
  include Clearance::User

  has_many :authentications, :dependent => :destroy
  has_many :listings

  def self.create_with_auth_and_hash(authentication,auth_hash)
    create! do |u|
      # u.first_name = auth_hash["info"]["first_name"] This is commented as whatever is here is requested from facebook
      u.email = auth_hash["extra"]["raw_info"]["email"]
      # this following line is a trick to avoid having an empty password field
      u.password = rand(1..9999999999999999)
      u.authentications<<(authentication)
    end
  end

  def fb_token
    x = self.authentications.where(:provider => :facebook).first
    return x.token unless x.nil?
  end

  def password_optional?
    true
  end
end


