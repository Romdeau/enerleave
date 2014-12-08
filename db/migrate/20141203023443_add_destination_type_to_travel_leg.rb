class AddDestinationTypeToTravelLeg < ActiveRecord::Migration
  def change
    remove_column :travel_legs, :destination_address
    remove_column :travel_legs, :destination_suburb
    remove_column :travel_legs, :destination_state
    remove_column :travel_legs, :destination_postcode
    add_column :travel_legs, :destination_type, :string
    add_column :travel_legs, :booking_status, :string
  end
end
