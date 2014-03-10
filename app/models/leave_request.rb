class LeaveRequest < ActiveRecord::Base
	require 'csv'
  	validates :employee, :leave_type, :end_date, :start_date, presence: true

  	LEAVE_TYPES = %w[annual sick personal compassionate time\ off\ without\ pay defence jury\ duty maternity/parental long\ service\ leave other]

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
