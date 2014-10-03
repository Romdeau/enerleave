# == Schema Information
#
# Table name: flights
#
#  id               :integer          not null, primary key
#  travel_leg_id    :integer
#  preffered_flight :string(255)
#  preffered_time   :string(255)
#  takeoff_location :string(255)
#  landing_location :string(255)
#  flight_date      :datetime
#  comment          :string(255)
#  created_at       :datetime
#  updated_at       :datetime
#  booked           :boolean
#  booking_comment  :string(255)
#  return           :boolean
#

require 'test_helper'

class FlightTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
