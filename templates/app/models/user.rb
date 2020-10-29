class User < ApplicationRecord
  include Clearance::User

  # Extra email validations (The other validations for passwords, etc.
  # are built directly into Clearance
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }

  enum role: [:guest, :admin]
  after_initialize :set_default_role, :if => :new_record?

  def admin?
    self.role == "admin"
  end

  def guest?
    self.role == "guest"
  end

  private
    def set_default_role
      self.role ||= :guest
    end

end
