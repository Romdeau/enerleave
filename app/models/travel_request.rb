# == Schema Information
#
# Table name: travel_requests
#
#  id         :integer          not null, primary key
#  start_date :datetime
#  end_date   :datetime
#  comment    :string(255)
#  user_id    :integer
#  created_at :datetime
#  updated_at :datetime
#

class TravelRequest < ActiveRecord::Base
  has_many :travel_leg
  belongs_to :user

  validates :start_date, presence: true
  validates :end_date, presence: true

  def request_booked?
    @travel_legs = self.travel_leg
    @unbooked_legs = 0
    @travel_legs.each do |travel_leg|
      if travel_leg.leg_booked? == false
        @unbooked_legs = @unbooked_legs + 1
      end
    end
    if @unbooked_legs > 0
      false
    else
      true
    end
  end

  def unbooked_legs
    @travel_legs = self.travel_leg
    @unbooked_legs = 0
    @travel_legs.each do |travel_leg|
      if travel_leg.leg_booked? == false
        @unbooked_legs = @unbooked_legs + 1
      end
    end
    @unbooked_legs
  end
end
