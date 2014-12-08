# == Schema Information
#
# Table name: travel_legs
#
#  id                :integer          not null, primary key
#  travel_request_id :integer
#  date_start        :datetime
#  date_end          :datetime
#  destination_city  :string(255)
#  comment           :string(255)
#  created_at        :datetime
#  updated_at        :datetime
#  fully_booked      :boolean
#  destination_type  :string(255)
#  booking_status    :string(255)
#

require 'test_helper'

class TravelLegTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
