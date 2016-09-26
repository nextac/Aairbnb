class CreateUnavdates < ActiveRecord::Migration
  def change
    create_table :unavdates do |t|

      t.date     "start_date"
      t.date     "end_date"
      t.integer  "listing_id"
      t.timestamps null: false
    end
  end
end
