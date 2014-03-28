class User < ActiveRecord::Base
  authenticates_with_sorcery!

  validates :password, length: { minimum: 3 }
  validates :password, confirmation: true
  validates :password_confirmation, presence: true

  validates :email, uniqueness: true

  has_many :toil_request, dependent: :destroy
  has_many :spend_toil, dependent: :destroy
  has_many :leave_request, dependent: :destroy

  validate :eneraque_email?

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
    valid_leave = valid_leave.sort_by &:date_accrued_end
    valid_leave.first
  end

  def eneraque_email?
    @email_array = manager_email.split("@")
    if @email_array[1] != "eneraque.com"
      errors.add(:manager_email, "this is not a valid @eneraque.com email")
    end
  end

  def check_manager
    @manager = User.find_by email: manager_email
    if @manager == nil or @manager.role == "user"
      UserMailer.notify_not_manager(self).deliver
    end
  end
end
