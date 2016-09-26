class AddUnavdateToListings < ActiveRecord::Migration
  def change
    add_column :listings, :unavdate, :string
  end
end
