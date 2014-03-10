class Costcenter < ActiveRecord::Base
	has_many :timeitem, dependent: :destroy

	validates :cost_code, uniqueness: true
end
