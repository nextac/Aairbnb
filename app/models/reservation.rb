class Reservation < ActiveRecord::Base
  belongs_to :user
  belongs_to :listing

  mount_uploaders :avatars, AvatarUploader
end
