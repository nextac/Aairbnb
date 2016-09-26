class Listing < ActiveRecord::Base

  belongs_to :user
  has_many :reservations
  has_many :unavdates

  mount_uploaders :avatars, AvatarUploader

  acts_as_taggable # Alias for acts_as_taggable_on :tags
end
