class CreateCarHires < ActiveRecord::Migration
  def change
    create_table :car_hires do |t|
      t.belongs_to :travel_leg
      t.string :driver
      t.string :pickup_location
      t.datetime :pickup_date
      t.datetime :dropoff_date
      t.string :dropoff_location
      t.string :comment

      t.timestamps
    end
  end
end
