# == Schema Information
#
# Table name: accommodations
#
#  id                 :integer          not null, primary key
#  travel_leg_id      :integer
#  preffered_location :string(255)
#  check_in           :datetime
#  check_out          :datetime
#  comment            :string(255)
#  created_at         :datetime
#  updated_at         :datetime
#

class Accommodation < ActiveRecord::Base
  belongs_to :travel_leg
  
end
