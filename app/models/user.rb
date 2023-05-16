class User < ApplicationRecord
  has_secure_password
  ROLES = %i[admin moderator normal banned]

  has_many :email_verification_tokens, dependent: :destroy
  has_many :password_reset_tokens, dependent: :destroy
  has_many :sessions, dependent: :destroy
  has_many :recovery_codes, dependent: :destroy
  has_many :posts

  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, allow_nil: true, length: { minimum: 12 }
  validates :password, not_pwned: { message: "might easily be guessed" }

  before_validation if: -> { email.present? } do
    self.email = email.downcase.strip
  end

  before_validation if: :email_changed?, on: :update do
    self.verified = false
  end

  before_create do
    self.otp_secret = ROTP::Base32.random
  end

  after_update if: :password_digest_previously_changed? do
    sessions.where.not(id: Current.session).delete_all
  end
  def is_normal?
    is_admin? || is_moderator? || role == "normal" || role.nil?
  end
  def is_admin?
    role == "admin"
  end

  def is_moderator?
    role == "moderator" || is_admin?
  end
  def is_banned?
    role == "banned"
  end
end
