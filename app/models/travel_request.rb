# == Schema Information
#
# Table name: travel_requests
#
#  id               :integer          not null, primary key
#  user_id          :integer
#  start_date       :datetime
#  end_date         :datetime
#  comment          :string(255)
#  created_at       :datetime
#  updated_at       :datetime
#  lodged           :boolean
#  fully_booked     :boolean
#  manager_approved :boolean
#

class TravelRequest < ActiveRecord::Base
  has_many :travel_leg
  belongs_to :user

  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :comment, presence: true

  def request_booked?
    @travel_legs = self.travel_leg
    if @travel_legs.size > 0
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
    else
      false
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

  def legs_booked?
    @travel_legs = self.travel_leg
    if @travel_legs.size > 0
      @unbooked_legs = 0
      @travel_legs.each do |travel_leg|
        if travel_leg.fully_booked != true
          @unbooked_legs = @unbooked_legs + 1
        end
      end
      if @unbooked_legs > 0
        false
      else
        true
      end
    else
      false
    end
  end
end
