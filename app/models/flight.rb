# == Schema Information
#
# Table name: flights
#
#  id               :integer          not null, primary key
#  travel_leg_id    :integer
#  preffered_flight :string(255)
#  preffered_time   :string(255)
#  takeoff_location :string(255)
#  landing_location :string(255)
#  flight_date      :datetime
#  comment          :string(255)
#  created_at       :datetime
#  updated_at       :datetime
#  booked           :boolean
#  booking_comment  :string(255)
#  return           :boolean
#  return_date      :datetime
#

class Flight < ActiveRecord::Base
  belongs_to :travel_leg

  validates :takeoff_location, :landing_location, presence: true
  validate :valid_return

  def valid_return
    if self.return == true and self.return_date == nil
      errors.add(:return_date, "A return flight must have a date")
    end
  end
end
