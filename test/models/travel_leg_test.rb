# == Schema Information
#
# Table name: travel_legs
#
#  id                   :integer          not null, primary key
#  travel_request_id    :integer
#  date_start           :datetime
#  date_end             :datetime
#  destination_address  :string(255)
#  destination_suburb   :string(255)
#  destination_city     :string(255)
#  destination_state    :string(255)
#  destination_postcode :string(255)
#  comment              :string(255)
#  created_at           :datetime
#  updated_at           :datetime
#  fully_booked         :boolean
#

require 'test_helper'

class TravelLegTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
