class ToilRequest < ActiveRecord::Base
  belongs_to :user

  def toil_valid?
  	# Checks if the date accrued is in the last 30 days. 
  	# Returns true if less than 30 days old.
  	if self.date_accrued > 30.days.ago
  		true
  	else
  		false
  	end
  end

  
end
