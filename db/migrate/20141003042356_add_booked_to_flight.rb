class AddBookedToFlight < ActiveRecord::Migration
  def change
    add_column :flights, :booked, :boolean
    add_column :flights, :booking_comment, :string
    add_column :accommodations, :booked, :boolean
    add_column :accommodations, :booking_comment, :string
    add_column :car_hires, :booked, :boolean
    add_column :car_hires, :booking_comment, :string
  end
end
