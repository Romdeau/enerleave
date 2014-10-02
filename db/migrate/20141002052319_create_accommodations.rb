class CreateAccommodations < ActiveRecord::Migration
  def change
    create_table :accommodations do |t|
      t.belongs_to :travel_leg
      t.string :preffered_location
      t.datetime :check_in
      t.datetime :check_out
      t.string :comment

      t.timestamps
    end
  end
end
