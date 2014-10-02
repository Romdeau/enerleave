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
#

require 'test_helper'

class CarHireTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
