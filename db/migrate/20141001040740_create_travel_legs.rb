class CreateTravelLegs < ActiveRecord::Migration
  def change
    create_table :travel_legs do |t|
      t.belongs_to :travel_request
      t.datetime :date_start
      t.datetime :date_end
      t.string :destination_address
      t.string :destination_suburb
      t.string :destination_city
      t.string :destination_state
      t.string :destination_postcode
      t.string :comment

      t.timestamps
    end
  end
end
