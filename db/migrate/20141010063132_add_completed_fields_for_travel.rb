class AddCompletedFieldsForTravel < ActiveRecord::Migration
  def change
    add_column :travel_requests, :fully_booked, :boolean
    add_column :travel_legs, :fully_booked, :boolean
  end
end
