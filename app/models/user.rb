class User < ActiveRecord::Base
  authenticates_with_sorcery!

  validates :password, length: { minimum: 3 }
  validates :password, confirmation: true
  validates :password_confirmation, presence: true

  validates :email, uniqueness: true

  has_many :toil_request, dependent: :destroy
  has_many :spend_toil, dependent: :destroy

  ROLES = %w[user manager admin]
end
