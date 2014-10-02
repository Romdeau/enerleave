# == Schema Information
#
# Table name: travel_legs
#
#  id                :integer          not null, primary key
#  travel_request_id :integer
#  date_start        :datetime
#  date_end          :datetime
#  comment           :string(255)
#  created_at        :datetime
#  updated_at        :datetime
#

class TravelLeg < ActiveRecord::Base
  belongs_to :travel_request
  has_many :flight
  has_many :car_hire
  has_many :accommodation
end
