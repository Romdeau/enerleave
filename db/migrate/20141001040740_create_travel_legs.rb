class CreateTravelLegs < ActiveRecord::Migration
  def change
    create_table :travel_legs do |t|
      t.belongs_to :travel_request
      t.datetime :date_start
      t.datetime :date_end
      t.boolean :flight
      t.string :flight_comment
      t.boolean :car
      t.string :car_comment
      t.boolean :accommodation
      t.string :accommodation_comment

      t.timestamps
    end
  end
end
