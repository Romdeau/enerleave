class User < ActiveRecord::Base
  authenticates_with_sorcery!

  validates :password, length: { minimum: 3 }
  validates :password, confirmation: true
  validates :password_confirmation, presence: true

  validates :email, uniqueness: true

  has_many :toil_request, dependent: :destroy
  has_many :spend_toil, dependent: :destroy

  ROLES = %w[user manager admin]

  def count_toil
  	self.toil_request.count
  end

  def total_toil
  	total_leave = 0
  	self.toil_request.each do |toil|
  		if toil.toil_valid?
  			total_leave += toil.amount
  		end
  	end
  	total_leave
  end

  def count_spend
	self.spend_toil.count
  end

  def total_spend
  	total_leave = 0
  	self.spend_toil.each do |toil|
  		if toil.toil_valid?
        total_leave += toil.amount
      end
  	end
  	total_leave
  end

  def oldest_valid
  	# Finds the oldest valid request for a user.
  	valid_leave = self.toil_request.select { |toil| toil.toil_valid? }.select { |toil| toil.amount > 0}
    valid_leave = valid_leave.sort_by &:date_accrued
    valid_leave.first
  end
end
