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
end
