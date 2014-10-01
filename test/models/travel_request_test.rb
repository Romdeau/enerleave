# == Schema Information
#
# Table name: travel_requests
#
#  id         :integer          not null, primary key
#  start_date :datetime
#  end_date   :datetime
#  comment    :string(255)
#  user_id    :integer
#  created_at :datetime
#  updated_at :datetime
#

require 'test_helper'

class TravelRequestTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
