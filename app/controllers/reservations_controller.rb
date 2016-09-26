class ReservationsController < ApplicationController

  before_action :set_reservation, only: [ :destroy]


  def new

      @reservation = Reservation.new
      @listing = Listing.find(params[:listing_id])
  end


  def create
    # byebug
    listing = Listing.find(params[:listing_id])
    reservation = current_user.reservations.new(reservation_params)

    if reservation.save
      # I want o go to my listing show page
       redirect_to root_path #to change later for a reservation summmary page
    else
      root_path
    end

  end


  def destroy



  end





private
  # The following method is called strong params see google
  def reservation_params
    params.require(:reservation).permit(:start_date, :end_date, :confirmation_status, :guest_count, :total, :user_id, :listing_id)

  end

  def set_reservation
    @reservation = Reservation.find(params[:id])

  end

end
