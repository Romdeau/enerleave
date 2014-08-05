# == Schema Information
#
# Table name: part_days
#
#  id               :integer          not null, primary key
#  leave_request_id :integer
#  leave_date       :datetime
#  time             :integer
#  created_at       :datetime
#  updated_at       :datetime
#

require 'test_helper'

class PartDayTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
