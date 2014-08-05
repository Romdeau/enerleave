# == Schema Information
#
# Table name: leave_requests
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  start_date :date
#  end_date   :date
#  created_at :datetime
#  updated_at :datetime
#  leave_type :string(255)
#  comment    :string(255)
#  approved   :string(255)
#

require 'test_helper'

class LeaveRequestTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
