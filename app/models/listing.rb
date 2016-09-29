class Listing < ActiveRecord::Base

  belongs_to :user
  has_many :reservations


  mount_uploaders :avatars, AvatarUploader

  acts_as_taggable # Alias for acts_as_taggable_on :tags

  searchkick match: :word_start, searchable: [:name, :location]

  #PART OF THE LOGIC FRO RESERVATION
  #In your Listing model, create a method that stores an array of reservations
  # dates upon creating, so it that people
  # cant book it twice(models/listing.rb)
  def booked_dates
      dates_tht_are_booked = []
      self.reservations.each do |reservation|
          reservation.dates.each do |date|
              dates_tht_are_booked <<date
          end
      end
      return dates_tht_are_booked

  end
end
