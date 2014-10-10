class AddLodgedToTravelRequest < ActiveRecord::Migration
  def change
    add_column :travel_requests, :lodged, :boolean
  end
end
