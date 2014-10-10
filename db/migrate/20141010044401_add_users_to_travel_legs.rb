class AddUsersToTravelLegs < ActiveRecord::Migration
  create_table :travel_legs_users, id: false do |t|
      t.belongs_to :user
      t.belongs_to :travel_leg
    end
end
