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

class ToilRequest < ActiveRecord::Base
  belongs_to :user

  validates :user, :date_accrued, :date_accrued_end, presence: true

  validates :amount, numericality: { greater_than_or_equal_to: 0 }

  attr_accessor :comment

  def toil_valid?
  	# Checks if the date accrued is in the last 30 days.
  	# Returns true if less than 30 days old.
  	if self.date_accrued_end > 30.days.ago and self.approved == 'true'
  		true
  	else
  		false
  	end
  end
end
