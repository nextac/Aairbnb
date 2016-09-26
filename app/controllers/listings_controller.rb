class ListingsController < ApplicationController
# This is a fast way to require someting before. See set_listing method in private folder.
  before_action :set_listing, only: [:show, :update, :edit, :destroy]

  def index
    # if signed_in?
    #   redirect_to users_path
    # end
    @listing = Listing.all
  end


  def show
    @reservation = Reservation.new
  end


  def new
    @reservation = Reservation.new
    @listing = Listing.new

  end


  def create
    @listing = current_user.listings.new(listing_params)
      if @listing.save
        @listing.unavdates.new(params)
      # I want o go to my listing show page
        redirect_to listings_path # This is the way to pass in an id
      else
        redirect_to new_listing_path
      end
  end


  # The def edit is already done automatically with the def set listing
  # def edit
  #   @listing = Listing.find(params[:id])
  # end

  def update
    if @listing.update(listing_params)
      # The next line is because I need to call the user_id parameter

      @listing.user_id = current_user.id
      redirect_to listing_path(@listing.id)
    else
      redirect_to edit_listing_path(@listing.id)
    end

  end

  def destroy
  @listing.destroy
  redirect_to user_path(current_user.id)
  end








 # We put this in private so nobody can see the all params

  private
  # The following method is called strong params see google
  def listing_params
    params.require(:listing).permit(:title, :location, :description, :daily_rate, :nb_room, :issmoker, :haslatecheckout, :haskitchen, :haswifi, :hasswimmingpool, :tag_list, :user_id, {avatars:[]})

  end

  def set_listing
    @listing = Listing.find(params[:id])

  end

  # This prevents us to retype it for every other method
  # so i don't have  to find the listing id for show, update edit, delete and destroy


  # def show
  # @listing = Listing.find(params[:id])
  # end
  # def edit
  # @listing = Listing.find(params[:id])
  # end
  # def update
  # @listing = Listing.find(params[:id])
  # end

end # -- >  end of class
