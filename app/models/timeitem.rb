class Timeitem < ActiveRecord::Base
  belongs_to :user, dependent: :destroy
  belongs_to :timesheet, dependent: :destroy
  belongs_to :costcenter, dependent: :destroy
  belongs_to :project, dependent: :destroy
end
