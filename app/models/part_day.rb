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

class PartDay < ActiveRecord::Base
  belongs_to :leave_request
end
