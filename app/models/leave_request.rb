class LeaveRequest < ActiveRecord::Base
	require 'csv'

	belongs_to :user

  	validates :leave_type, :end_date, :start_date, presence: true
		validate :valid_leave_period?

  	LEAVE_TYPES = %w[annual sick personal compassionate time\ off\ without\ pay defence jury\ duty maternity/parental long\ service\ leave other]

	scope :approved_leave, -> { where approved: 'true' }
	scope :not_approved, -> { where approved: 'false'}

	def valid_leave_period?
		if self.end_date >= self.start_date
				true
		else
			errors.add(:start_date, ': start date cannot be after end date')
		end
	end

	def leave_approved?
		if self.approved == 'true'
			true
		else
			false
		end
	end

	def self.as_csv
		CSV.generate do |csv|
			csv << column_names
			all.each do |lrequest|
				csv << lrequest.attributes.values_at(*column_names)
			end
		end
	end

	def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      LeaveRequest.create! row.to_hash
    end
  end
end
