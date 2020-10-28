class Setting < ApplicationRecord

  validates :email, presence: true
  validates :site_name, presence: true
  validates :site_description, presence: true

end
