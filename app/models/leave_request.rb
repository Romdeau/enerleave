# == Schema Information
#
# Table name: leave_requests
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  start_date :date
#  end_date   :date
#  created_at :datetime
#  updated_at :datetime
#  leave_type :string(255)
#  comment    :string(255)
#  approved   :string(255)
#

class LeaveRequest < ActiveRecord::Base
	require 'csv'

	belongs_to :user

	has_many :part_days

  	validates :leave_type, :end_date, :start_date, :comment, presence: true
		validate :valid_leave_period?
		validate :not_weekend?

  	LEAVE_TYPES = %w[annual sick personal compassionate time\ off\ without\ pay defence jury\ duty maternity/parental long\ service\ leave other]

	scope :approved_leave, -> { where approved: 'true' }
	scope :not_approved, -> { where approved: 'false'}

	def not_weekend?
		if start_date.saturday? or start_date.sunday?
			errors.add(:start_date, "#{start_date} is a weekend.")
		end
		if end_date.saturday? or end_date.sunday?
			errors.add(:end_date, "#{end_date} is a weekend.")
		end
	end

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

	def leave_between?(date_start, date_end)
		if self.approved == 'true'
			#if the start date of the leave request is after the start date of the report
			if self.start_date >= Date.strptime("{ #{date_start} }", "{ %d/%m/%Y }")
				# and if the start date of the leave request is before the end date of the report
				if self.start_date <= Date.strptime("{ #{date_end} }", "{ %d/%m/%Y }")
					#then the leave starts between the leave period report dates or starts between and ends outside the leave period report dates
					true
				else
					false
				end
			#if the start date of the leave request is before the start date of the report
		elsif self.start_date <= Date.strptime("{ #{date_start} }", "{ %d/%m/%Y }")
				# and if the end date of the leave request is after the start date of the report
				if self.end_date >= Date.strptime("{ #{date_start} }", "{ %d/%m/%Y }")
					# then the leave request finishes inside the leave period report or finishes after the leave period report
					true
				else
					false
				end
			end
		else
			false
		end
	end

	def unapproved_between?(date_start, date_end)
		if self.approved == 'false'
			if self.start_date >= Date.strptime("{ #{date_start} }", "{ %d/%m/%Y }")
				if self.start_date <= Date.strptime("{ #{date_end} }", "{ %d/%m/%Y }")
					true
				else
					false
				end
			elsif self.start_date <= Date.strptime("{ #{date_start} }", "{ %d/%m/%Y }")
				if self.end_date >= Date.strptime("{ #{date_end} }", "{ %d/%m/%Y }")
					true
				else
					false
				end
			elsif self.end_date >= Date.strptime("{ #{date_start} }", "{ %d/%m/%Y }")
				if self.end_date <= Date.strptime("{ #{date_end} }", "{ %d/%m/%Y }")
					true
				else
					false
				end
			end
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
