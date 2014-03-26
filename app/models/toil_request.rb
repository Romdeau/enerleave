class ToilRequest < ActiveRecord::Base
  belongs_to :user

  validates :user, :date_accrued, :date_accrued_end, presence: true

  validates :amount, numericality: { greater_than_or_equal_to: 0 }

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
