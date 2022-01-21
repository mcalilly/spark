class Setting < ApplicationRecord

  validates :site_title, presence: true
  validates :site_tagline, presence: true
  validates :site_description, presence: true
  validates :instagram_handle, presence: true
  validates :facebook_handle, presence: true
  validates :twitter_handle, presence: true
  validate  :only_one_record_allowed

  # Extra email validations (The other validations for passwords, email presence, that we test for are handled by Devise)
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email,
              presence: true,
              format: {
                with: VALID_EMAIL_REGEX,
                message: "format is invalid"
              }
  private

    def only_one_record_allowed
      if Setting.all.count >= 1
        errors[:base] << "You can only have one group of settings."
      end
    end
end
