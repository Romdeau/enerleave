class CreateFlights < ActiveRecord::Migration
  def change
    create_table :flights do |t|
      t.belongs_to :travel_leg
      t.string :preffered_flight
      t.string :preffered_time
      t.string :takeoff_location
      t.string :landing_location
      t.datetime :flight_date
      t.string :comment

      t.timestamps
    end
  end
end
