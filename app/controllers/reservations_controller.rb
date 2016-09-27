class ReservationsController < ApplicationController

  before_action :set_reservation, only: [ :destroy]


  def new

      @reservation = Reservation.new
      @listing = Listing.find(params[:listing_id])
  end


  # def create
  #   # byebug
  #   listing = Listing.find(params[:listing_id])
  #   reservation = current_user.reservations.new(reservation_params)

  #   if reservation.save
  #     # I want o go to my listing show page
  #      redirect_to root_path #to change later for a reservation summmary page
  #   else
  #     root_path
  #   end

  # end

  def create
    @listing = Listing.find(params[:listing_id])
    @reservation = current_user.reservations.new(reservation_params)
    booked_dates = @listing.booked_dates
    @host = "david.nextacademy@gmail.com"
      if @reservation.overlapping_dates(booked_dates).empty? && @reservation.save
        #this checks if the booked_dates are empty, if is empty then it will create
        #a new reservation
        #once im able to create a new reservation, i would need to add my listing_id
        #into my reservation as i only have user_id for now (current_user.reservations)
        @reservation.update(listing_id: @listing.id)
        # ReservationMailer to send a notification email after save
        #
        @host = "david.nextacademy@gmail.com"
            #DAVID !!!!
            #If I want to use mailer then uncomment line below!!!
          # ReservationMailer.notification_email("david.nextacademy@gmail.com", "david.nextacademy@gmail.com", 1, 1).deliver_now
          #ReservationJob.perform_now("david.nextacademy@gmail.com", "david.nextacademy@gmail.com", 1, 1)

          # IF I WANT TO USE REDIS AND SIDEKIQ THEN USE line below
          ReservationJob.perform_now(current_user.email, @host, @reservation.listing.id, @reservation.id)
           # ReservationMailer.notification_email(current_user.email, @host, @reservation.listing.id, @reservation.id).deliver_later
          # call out reservation job to perform the mail sending task after @reservation is successfully saved
            redirect_to root_path
        else
          flash[:notice] = "dates are no available on #{@reservation.overlapping_dates(booked_dates).join(", ")}"
          redirect_to root_path
        end
  end



  def destroy



  end #end of class





private
  # The following method is called strong params see google
  def reservation_params
    params.require(:reservation).permit(:start_date, :end_date, :confirmation_status, :guest_count, :total, :user_id, :listing_id)

  end

  def set_reservation
    @reservation = Reservation.find(params[:id])

  end

end
