class SpendToil < ActiveRecord::Base
  belongs_to :user

  validates :user_id, :leave_date, presence: true

  validates :amount, numericality: { greater_than_or_equal_to: 0 }

  def process_leave
    #processing leave transaction
    #find the user for this toil leave request
    existing_user = User.find(self.user.id)
    #while the leave request has more than 0 minutes remaining to process keep processing
    while self.amount > 0 do
    	#set the leave to be subtracted from as the oldest
		existing_leave = existing_user.oldest_valid
		#set the leave amount to be the amount of leave remaining to be allocated
		leave_amount = self.amount
		#if the leave amount is less than or equal to the amount of leave available on the oldest valid toil request remove the leave request amount from both records.
		if existing_leave.amount >= leave_amount
	        existing_leave.amount -= leave_amount
	        self.amount -= leave_amount
	        if existing_leave.save
            if self.save
            else
              fail
            end
          end
      #otherwise the request must be for more than the leave available on this request, so subtrac the available from both.
		else
			leave_amount = existing_leave.amount
			self.amount -= leave_amount
			existing_leave.amount = 0
			if self.save
			 if existing_leave.save
       else
         fail
       end
     end
		end
    end
    true
  end

  def toil_valid?
  	# Checks if the date accrued is in the last 30 days.
  	# Returns true if less than 30 days old.
  	if self.leave_date > 30.days.ago and self.approved == 'true'
  		true
  	else
  		false
  	end
  end
end
