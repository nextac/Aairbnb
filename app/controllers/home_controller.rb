class HomeController < ApplicationController
  def index

    @reservation = Reservation.new
    listings_per_page = 9
    params[:page] = 1 unless params[:page]
    first_listing = (params[:page].to_i - 1 ) * listings_per_page
    listings = Listing.all
    @total_pages = listings.count / listings_per_page
    if listings.count % listings_per_page > 0
      @total_pages += 1
    end
      @listings = listings[first_listing...(first_listing + listings_per_page)]
  end
end
