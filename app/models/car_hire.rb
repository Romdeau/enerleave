# == Schema Information
#
# Table name: car_hires
#
#  id               :integer          not null, primary key
#  travel_leg_id    :integer
#  driver           :string(255)
#  pickup_location  :string(255)
#  pickup_date      :datetime
#  dropoff_date     :datetime
#  dropoff_location :string(255)
#  comment          :string(255)
#  created_at       :datetime
#  updated_at       :datetime
#  booked           :boolean
#  booking_comment  :string(255)
#

class CarHire < ActiveRecord::Base
  belongs_to :travel_leg

  validates :driver, :pickup_location, :dropoff_location, presence: true
end
