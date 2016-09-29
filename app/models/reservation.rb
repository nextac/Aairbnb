class Reservation < ActiveRecord::Base
  belongs_to :user
  belongs_to :listing
  has_many :payments

  mount_uploaders :avatars, AvatarUploader

  #PART OF THE LOGIC OF RESERVATION
  #In your Reservation model, create a method that takes the start date
  # to the end date, and covert it into an array (models/reservation.rb)
def dates
     (start_date..end_date).to_a
end

#Now i would need a method to see which dates are overlapping
# so go to (models/reservation.rb)
    def overlapping_dates(booked_dates)

        dates & booked_dates
    end
#dates refer to the method dates, which is the start and end dates,
#compared it with the existing dates in the array of booked dates,
#if there are any

  def total_calculation

    self.dates.length * self.listing.daily_rate
  end



end
