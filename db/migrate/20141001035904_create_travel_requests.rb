class CreateTravelRequests < ActiveRecord::Migration
  def change
    create_table :travel_requests do |t|
      t.belongs_to :user
      t.datetime :start_date
      t.datetime :end_date
      t.string :comment

      t.timestamps
    end
  end
end
