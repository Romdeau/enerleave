class Timesheet < ActiveRecord::Base
  belongs_to :user
  belongs_to :timeweek

  validates_uniqueness_of :timesheet_date, :scope => :user
end
