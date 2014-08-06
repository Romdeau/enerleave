# == Schema Information
#
# Table name: part_days
#
#  id               :integer          not null, primary key
#  leave_request_id :integer
#  part_date        :date
#  part_start       :datetime
#  part_end         :datetime
#  created_at       :datetime
#  updated_at       :datetime
#

class PartDay < ActiveRecord::Base
  belongs_to :leave_request

  validate :not_weekend?

  def not_weekend?
    if part_date.saturday? or part_date.sunday?
      errors.add(:part_date, "#{part_date} is a weekend.")
    end
  end

  def part_length
    ((part_end - part_start) / 3600)
  end
end
