# == Schema Information
#
# Table name: travel_legs
#
#  id                :integer          not null, primary key
#  date_start        :datetime
#  date_end          :datetime
#  flight            :boolean
#  flight_comment    :string(255)
#  car               :boolean
#  car_comment       :string(255)
#  accommodation     :string(255)
#  travel_request_id :integer
#  created_at        :datetime
#  updated_at        :datetime
#

require 'test_helper'

class TravelLegTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
