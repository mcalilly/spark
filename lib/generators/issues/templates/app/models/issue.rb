class Issue < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: :slugged

  has_rich_text :body

  validates :title, presence: true, uniqueness: { case_sensitive: false }
  validates :body, presence: true

end
