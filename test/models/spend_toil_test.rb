# == Schema Information
#
# Table name: spend_toils
#
#  id               :integer          not null, primary key
#  user_id          :integer
#  initial_amount   :integer
#  amount           :integer
#  leave_date       :date
#  approved         :string(255)
#  created_at       :datetime
#  updated_at       :datetime
#  manager_approved :boolean          default(FALSE)
#

require 'test_helper'

class SpendToilTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
