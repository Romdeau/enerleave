# == Schema Information
#
# Table name: travel_requests
#
#  id           :integer          not null, primary key
#  user_id      :integer
#  start_date   :datetime
#  end_date     :datetime
#  comment      :string(255)
#  created_at   :datetime
#  updated_at   :datetime
#  lodged       :boolean
#  fully_booked :boolean
#

require 'test_helper'

class TravelRequestTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
