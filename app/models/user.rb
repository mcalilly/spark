class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Extra email validations (The other validations for passwords, email presence, that we test for are handled by Devise)
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email,
            length: {
              maximum: 255,
              message: "must be less than 255 characters"
            },
            format: {
              with: VALID_EMAIL_REGEX,
              message: "format is invalid"
            },
            uniqueness: {
              case_sensitive: false,
              message: "is already taken"
            }

  # User roles
  enum role: [:admin, :guest]
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
