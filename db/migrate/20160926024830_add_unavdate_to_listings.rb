class AddUnavdateToListings < ActiveRecord::Migration
  def change
    add_column :listings, :unavdate, :text, array:true, default: []
  end
end
