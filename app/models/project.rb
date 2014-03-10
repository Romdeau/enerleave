class Project < ActiveRecord::Base
	has_many :timeitem, dependent: :destroy

	validates :project_number, uniqueness: true
end
