# == Schema Information
#
# Table name: user_audits
#
#  id          :integer          not null, primary key
#  user_id     :integer
#  action      :string(255)
#  description :string(255)
#  end_user    :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#

require 'test_helper'

class UserAuditTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
