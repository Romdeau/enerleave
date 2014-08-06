# == Schema Information
#
# Table name: part_days
#
#  id               :integer          not null, primary key
#  leave_request_id :integer
#  part_date        :date
#  part_start       :datetime
#  part_end         :datetime
#  created_at       :datetime
#  updated_at       :datetime
#

require 'test_helper'

class PartDayTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
