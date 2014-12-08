# == Schema Information
#
# Table name: toil_requests
#
#  id               :integer          not null, primary key
#  user_id          :integer
#  initial_amount   :integer
#  amount           :integer
#  date_accrued     :date
#  approved         :string(255)
#  created_at       :datetime
#  updated_at       :datetime
#  date_accrued_end :date
#  manager_approved :boolean          default(FALSE)
#

require 'test_helper'

class ToilRequestTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
