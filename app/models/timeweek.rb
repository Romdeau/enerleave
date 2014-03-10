class Timeweek < ActiveRecord::Base
  belongs_to :user
  has_many :timesheet, dependent: :destroy

  validates_uniqueness_of :start_date, :scope => :user
end
